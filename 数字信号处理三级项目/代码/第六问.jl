using TyBase
using TyMath
using TyPlot

# 定义处理函数cul_fft，采样信号频率frq，总采样时长T
function cul_fft(frq,T)
    t_f=1/100               # 采样间隔0.01秒
    t=0:t_f:T               # 生成采样点
    y=sin.(frq*2*pi*t)      # 对信号采样
    y_s=fft(y)              # 快速傅里叶变换
    y_s=y_s[1:div(length(y_s),2)]   # 去除周期延拓信号
    return y_s              # 返回频谱
end
####  采样时长为4秒的整周期采样  ####
subplot(1,2,1)              # 绘制子图1
plot(abs.(cul_fft(20,4)))   # 绘制20Hz频谱，采样4秒的频谱
hold("on")                  # 保留曲线
plot(abs.(cul_fft(25,4)))   # 绘制25Hz频谱，采样4秒的频谱
title("整周期采样频谱")

####  采样时长为4.2秒的非整周期采样  ####
subplot(1,2,2)              # 绘制子图2
plot(abs.(cul_fft(20,4.02)))# 绘制20Hz频谱，采样4.02秒的频谱
hold("on")                  # 保留曲线
plot(abs.(cul_fft(25,4.02)))# 绘制25Hz频谱，采样4.02秒的频谱
title("整周期采样频谱")