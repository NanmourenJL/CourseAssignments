#/********************************************************************
# Copyright(C) 2024 I.S.E.,YanShan University. All rights reserved.
# File Name: 不等精度.jl
# Author: Yinlong You
# Version: V1.0
# Date: 2024/5/23
# Description: 
#  需要使用等精度.jl中的函数（为了减少代码量，不复制），故先运行等精度测量
#  后方可无报错运行不等精度
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

########主函数始########
#清屏
clc()
clear()

#导入数据
file_select=2
file_name=["电压（量程40V，最小刻度0.01V）.csv","电压（量程4V，最小刻度0.001V）.csv","电流（量程40μA，最小刻度0.01μA）.csv","电流（量程400μA，最小刻度0.1μA）.csv"]
file_path = joinpath(@__DIR__, file_name[(file_select-1)*2+1])
Data_frame = DataFrame(CSV.File(file_path));
Data_array = Array(Data_frame[:, begin:end])
print("对数据1进行等精度处理：")
x1=deal_data(Data_array);
file_path = joinpath(@__DIR__, file_name[(file_select-1)*2+2])
Data_frame = DataFrame(CSV.File(file_path));
Data_array = Array(Data_frame[:, begin:end])
print("\n\n对数据2进行等精度处理：")
x2=deal_data(Data_array);

print("\n\n对两组数据等精度处理后的结果进行不等精度处理\n")
x_1 = x1[1]
σ_1 = x1[2]
x_2 = x2[1]
σ_2 = x2[2]

#第一步：求加权算数平均值
print("第一步：求加权算数平均值")
p_1 = σ_2^2
p_2 = σ_1^2
x_mean= (x_1 * p_1 + x_2 * p_2) / (p_1 + p_2)
print("\n加权算数平均值为",x_mean)

#第二步：求残余误差
print("\n\n第二步：求残余误差")
v_1 = x_1 - x_mean
v_2 = x_2 - x_mean
print("\n各测得值的残余误差为",round(v_1;digits=5),"，",round(v_2;digits=5))

#第三步：求加权算数平均值的标准差
print("\n\n第三步：求加权算数平均值的标准差")
σ_x = σ_1 * sqrt(p_1 / (p_1 + p_2))
print("\n加权算数平均值的标准差为",round(σ_x;digits=5))

#第四步：求加权算数平均值的极限误差 
print("\n\n第四步：求加权算数平均值的极限误差")
δ=3*σ_x
print("\n取置信系数t=3，求得加权算数平均值的极限误差δ为",round(δ;digits=5))

#第五步：写出最后测量结果
print("\n\n第五步：写出最后测量结果\n")
digit=floor(log10(δ))
if floor(δ*10^(-digit)) != δ*10^(-digit)
    δ=(floor(δ*10^(-digit))+1)/(10^(-digit))
end
x_mean=round(x_mean;digits=(Int64)(-digit))
print("测量结果为：",x_mean,"±",δ)