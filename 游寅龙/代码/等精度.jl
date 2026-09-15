#/********************************************************************
# Copyright(C) 2024 I.S.E.,YanShan University. All rights reserved.
# File Name: 等精度.jl
# Author: Yinlong You
# Version: V1.0
# Date: 2024/5/23
# Description: 
#  第234行的变量file_select作用是选择数据处理的文件，不同值对应文件如下
#  1 -> 电压（量程40V，最小刻度0.01V）
#  2 -> 电压（量程4V，最小刻度0.001V）
#  3 -> 电流（量程40μA，最小刻度0.01μA）
#  4 -> 电流（量程400μA，最小刻度0.1μA）
#********************************************************************/

using Printf
using TyBase
using CSV
using TySymbolicMath
using TyMath
using TyDeepLearning
using TyReportGenerator
using TyPlot
using TyBase

########打印数组########
function print_Array(array)
    for a in 1:size(array)[1]
        print(round(array[a];digits=5))
        if a != (size(array)[1])
            print(",")
        end
    end  
    print("\n")
end

########计算小数位数########
function calculate_number(number)
    A = 1.0
    for a in 1:5
        number = 10*number
        A= A / 10
        if number-floor(number)==0
            return A
        end
    end
    return 5
end

########对标准误差进行粗大误差判断########
function check_error(data_array,error_array,standad_number)
    b=false
    for a in 1:size(error_array)[1]
        if abs(error_array[a]) > standad_number
            print("\n第",a,"个数",data_array[a],"含有粗大出差，需要剔除")
            b=true
            return a
        end
    end 
    if b==false
        print("无粗大误差")
    end
    return -1
end

########对查询t的值########
function fint_t(number)
    error=100
    ans=0
    fun(x)= exp(-(x^2)/2)
    for t in 0:0.00001:2
        q,e = integral(fun, 0, t)
        q=q/sqrt(2*pi)
        if abs(q-number)<error
            error=abs(q-number)
            ans=t
        end
    end
    return ans
end

########数据处理主函数########
function deal_data(Data_array)
    data_size=size(Data_array)[1]
    while true
        #第一步：求算数平均值
        Data_mean = round(mean(Data_array);digits=5)
        print("\n第一步：求算数平均值\n求得测量列的算数平均值为",Data_mean,"\n")

        #第二步：求残余误差
        Error_array = ones(size(Data_array))
        for a in 1:data_size
            Error_array[a] = Data_array[a] - Data_mean
        end
        print("\n第二步：求残余误差\n各测得值的残余误差为")
        print_Array(Error_array)

        #第三步：校核算数平均值及其残余误差
        print("\n第三步：校核算数平均值及其残余误差\n现利用规则2进行校核：")
        A=calculate_number(Data_mean)
        if mod(data_size,2) == 0
            if abs(sum(Error_array)) <= data_size*A/2
                print("根据偶次测量的校核规则，以上计算正确，校核通过")
            else
                print("根据偶次测量的校核规则，以上计算错误，校核未通过")
            end
        else
            if abs(sum(Error_array)) <= (data_size/2-0.5)*A
                print("根据奇次测量的校核规则，以上计算正确，校核通过")
            else
                print("根据奇次测量的校核规则，以上计算错误，校核未通过")
            end
        end

        #第四步：判断系统误差
        if mod(data_size,2) == 0
            front = sum(Error_array[1:(Int64)(data_size/2)])
            back = sum(Error_array[(Int64)(data_size/2):(Int64)(data_size)])
        else
            front = sum(Error_array[1:(Int64)((data_size-1)/2)])
            back = sum(Error_array[(Int64)((data_size+1)/2):(Int64)(data_size)])
        end
        Δ=front-back
        print("\n\n第四步：判断系统误差\n按残余误差校核法：Δ为",round(mean(Δ);digits=5));
        if Δ < 0.01
            print("，Δ较小，故判断该测量列无系统误差存在")
        else
            print("，Δ较大，故判断该测量列有系统误差存在")
        end
        global σ_bessel=sqrt(sumsqr(Error_array)/(data_size-1))
        σ_peters=1.253*(sumabs(Error_array)/sqrt((data_size-1)*data_size))
        u=abs((σ_peters/σ_bessel)-1)
        print("\n按不同公式计算标准差法：u为",round(mean(u);digits=5))
        if u<2/sqrt(data_size-1)
            print("，u<",round(mean(2/sqrt(data_size-1));digits=5),"，故判断该测量列无系统误差存在")
        else
            print("，u>",round(mean(2/sqrt(data_size-1));digits=5),"，故判断该测量列有系统误差存在")
        end

        #第五步：求测量列单次测量的标准差
        print("\n\n第五步：求测量列单次测量的标准差\n")
        print("根据贝塞尔公式求得：σ为",round(mean(σ_bessel);digits=5))
        print("\n根据别捷尔斯公式求得：σ'为",round(mean(σ_peters);digits=5));

        #第六步：判别粗大误差
        print("\n\n第六步：判别粗大误差")
            #罗曼诺夫斯基准则
        Romano_list=[0,0,0,4.97,3.56,3.04,2.78,2.62,2.51,2.43,2.37,2.33,2.29,2.26,
                    2.24,2.22,2.20,2.18,2.17,2.16,2.15,2.14,2.13,2.12,2.11,2.10,
                    2.10,2.09,2.09,2.08,11.46,6.53,5.04,4.36,3.96,3.71,3.54,3.41,
                    3.31,3.23,3.17,3.12,3.08,3.04,3.01,3.00,2.95,2.93,2.91,2.90,
                    2.88,2.86,2.85,2.84,2.83,2.82,2.81]
        standad_number_Romano=Romano_list[data_size]*σ_bessel
        print("\n根据罗曼诺夫斯基准则（α=0.05时）：")
        error_index=check_error(Data_array,Error_array,standad_number_Romano)
        if error_index != -1 
            Data_array = Data_array[1:end .!= error_index, :]
            print("\n\n\n\n重新求解\n")
            print("剔除后，数据为")
            print_Array(Data_array)
            data_size=size(Data_array)[1]
            if data_size < 3
                print("\n数据已不足三个，结束计算")
                return
            end
            continue
        end
            #3σ准则（莱以特准则）
        standad_number_three_σ=3*σ_bessel
        print("\n根据3σ准则（莱以特准则）：")
        error_index=check_error(Data_array,Error_array,standad_number_three_σ)
        if error_index != -1 
            Data_array = Data_array[1:end .!= error_index, :]
            print("\n\n\n\n重新求解\n")
            print("剔除后，数据为")
            print_Array(Data_array)
            data_size=size(Data_array)[1]
            if data_size < 3
                print("\n数据已不足三个，结束计算")
                return
            end
            continue
        end
            #格罗布斯准则
        Grubbs_list=[0,0,1.15,1.46,1.67,1.82,1.94,2.03,2.11,2.18,2.23,2.28,2.33,
                    2.37,2.41,2.44,2.48,2.50,2.53,2.56,2.58,2.60,2.62,2.64,2.66]
        error_mean=mean(Error_array)
        print("\n根据格罗布斯准则（α=0.05时）：")
        if (maximum(Error_array)-error_mean)/σ_bessel < Grubbs_list[data_size]
            print("最大值不含有粗大误差")
        else
            print("最大值含有粗大误差，应当舍去")
        end
        if (error_mean-minimum(Error_array))/σ_bessel < Grubbs_list[data_size]
            print("；最小值不含有粗大误差")
        else
            print("；最小值含有粗大误差，应当舍去")
        end
        break
    end

    #第七步：求算数平均值的标准差
    print("\n\n第七步：求算数平均值的标准差")
    σ_x=σ_bessel/sqrt(data_size)
    print("\n求得算数平均值的标准差为",round(mean(σ_x);digits=5))

    #第八步：求算数平均值的极限误差
    print("\n\n第八步：求算数平均值的极限误差")
    limit_error_list = [12.71,4.30,3.18,2.78,2.57,2.45,2.36,2.31,2.26]
    if data_size<10
        δ=σ_x*limit_error_list[data_size-1]
        print("\n共",data_size,"个测量值，小于10个，故选用t分布计算算数平均值的极限误差，求得算数平均值的极限误差δ为",round(δ;digits=5))
    else
        t=fint_t(0.475)
        δ=t*σ_x
        print("\n共",data_size,"个测量值，大于10个，故选用χ方分布计算算数平均值的极限误差，求得算数平均值的极限误差δ为",round(δ;digits=5))
    end

    #第九步：写出最后测量结果
    print("\n\n第九步：写出最后测量结果\n")
    digit=floor(log10(δ))
    if floor(δ*10^(-digit)) != δ*10^(-digit)
        δ=(floor(δ*10^(-digit))+1)/(10^(-digit))
    end
    Data_mean=round(Data_mean;digits=(Int64)(-digit))
    print("测量结果为：",Data_mean,"±",δ)
    return (Data_mean,δ)
end

########主函数始########
#清屏
clc()
clear()

#导入数据
file_select=4
file_name=["电压（量程40V，最小刻度0.01V）.csv","电压（量程4V，最小刻度0.001V）.csv","电流（量程40μA，最小刻度0.01μA）.csv","电流（量程400μA，最小刻度0.1μA）.csv"]
file_path = joinpath(@__DIR__, file_name[file_select])
Data_frame = DataFrame(CSV.File(file_path));
Data_array = Array(Data_frame[:, begin:end])
print("原始数据为")
print_Array(Data_array)
deal_data(Data_array);