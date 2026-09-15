using TyControlSystems
using TyMath
using TyPlot
# 倒立摆系统参数
M = 2     # 小车质量2Kg
m = 0.1   # 摆球质量0.1Kg
l = 0.5   # 摆杆长度0.5m
g = 9.8   # 重力加速度9.8m/s^2
# 倒立摆系统状态空间矩阵定义
A = [0 1 0 0
    (M+m)*g/(M*l) 0 0 0
    0 0 0 1
    -m*g/M 0 0 0]
B = [0 -1 / (M * l) 0 1 / M]'
C = [0 0 1 0]
D = 0
# 倒立摆系统模型
G = ss(A, B, C, D)
#状态模型转化为zpk模型
Gzpk = zpk(G)
# 0型系统重构
Ahat = [A zeros(size(A, 1), 1); -C 0]
Bhat = [B; 0]
#判定重构系统能控性
r = rank([Ahat Bhat])
# 计算理想主导极点位置并分配系统所有极点位置
idealPoles = roots([1, 2 * 0.7 * 1, 1])
AllPoles = [idealPoles[1], idealPoles[2], -10, -15, -20]
# 极点配置，计算状态增益K
Khat = place(Ahat, Bhat, AllPoles)
# 状态增益值分解
K = reshape(real(Khat[1:4]), 1, 4)
k1 = -real(Khat[end])
# 闭环系统状态方程
AA = [A-B*K B*k1; -C 0]
BB = [0 0 0 0 1]'
CC = [C 0]
DD = 0
Gclose = ss(AA, BB, CC, DD)
# 计算并绘制阶跃响应
#step(Gclose, 10, linewidth = 2) 
y, t, x = step(Gclose, 10)
