using TyBase
using TyMath
using TyPlot

# 定义采样函数get_point，采样点数N
function get_point(N)
    t=0:1/100:(N-1)/100
    y=sin.(5.25*2*pi*t)
    return y
end

####  采样128次的128点FFT  ####
y=get_point(128)                # 获取128点采样点
y_s=fft(y)                      # 快速傅里叶变换
y_s=y_s[1:div(length(y_s),2)]   # 去除周期延拓信号
subplot(3,1,1)                  # 绘制子图1
plot(abs.(y_s))                 # 绘制频谱
title("采样128次的128点FFT")

####  采样128次的512点FFT  ####
y_1=get_point(128)              # 获取128点采样点
y=zeros(1,512)                  # 获得512点零数组
y[1,1:size(y_1)[1]]=y_1         # 将采样点补零
y_s=fft(y)                      # 快速傅里叶变换
y_s=y_s[1:div(length(y_s),2)]   # 去除周期延拓信号
subplot(3,1,2)                  # 绘制子图2
plot(abs.(y_s))                 # 绘制频谱
title("采样128次的512点FFT")

####  采样512次的512点FFT  ####
y=get_point(512)                # 获取512点采样点
y_s=fft(y)                      # 快速傅里叶变换
y_s=y_s[1:div(length(y_s),2)]   # 去除周期延拓信号
subplot(3,1,3)                  # 绘制子图3
plot(abs.(y_s))                 # 绘制频谱
title("采样512次的512点FFT")
