#/********************************************************************
# Copyright(C) 2024 I.S.E.,YanShan University. All rights reserved.
# File Name: 矩阵法最小二乘法.jl
# Author: Yinlong You
# Version: V1.0
# Date: 2024/5/23
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

#清屏
clc()
clear()

#导入数据
file_path = joinpath(@__DIR__,"最小二乘法计算电阻.csv")
Data_frame = DataFrame(CSV.File(file_path));
Data_array = Array(Data_frame[:, begin:end])

#得出相关系数矩阵
U=Data_array[:, :1:end .!= 2 ]
A=zeros(size(Data_array)[1],2)
for a in 1:size(Data_array)[1]
    global A
    A[a]=Data_array[a+size(Data_array)[1]]/1000
    A[a+size(Data_array)[1]]=-1
end

#计算得到估计值矩阵
C=transpose(A)*A
X=inv(C)*transpose(A)*U
R=X[1][1]
L=X[2][1]/X[1][1]

#计算得到单位权标准差
V=U-A*X
σ=sqrt(transpose(V)*V)/(size(Data_array)[1]-2)

#计算得到估计量标准差
C1=inv(C)
σ_1=(σ*sqrt(C1[1][1]))[1][1]
σ_2=(σ*sqrt(C1[4]))[1][1]/σ_1

#输出结果
digit=floor(log10(σ_1))
if floor(σ_1*10^(-digit)) != σ_1*10^(-digit)
    σ_1=(floor(σ_1*10^(-digit))+1)/(10^(-digit))
end
R=round(R;digits=(Int64)(-digit))
print("电阻测量结果为：",R,"±",σ_1)
digit=floor(log10(σ_2))
if floor(σ_2*10^(-digit)) != σ_2*10^(-digit)
    σ_2=(floor(σ_2*10^(-digit))+1)/(10^(-digit))
end
L=ceil(L;digits=(Int64)(-digit))
print("\n电流测量结果为：",L,"±",σ_2)