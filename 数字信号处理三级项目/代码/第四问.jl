using TyMath
using TyPlot

h = [2,1,1,0]     # 有限序列h(n)
x = [-1,0,0,1,0,2]  # 有限序列x(n)

####################线性卷积####################
y = conv(x,h)       # y(n)为x(n)和h(n)的线性卷积

subplot(1,2,1)      # 绘制散点图
stem(y)
title("直接线性卷积")

####################频域求解线性卷积####################
len = 16            # 补为16点，符合基2FFT
h=vcat(h,zeros(len-length(h)))
x=vcat(x,zeros(len-length(x)))

h_s = fft(h)        # 快速傅里叶FFT
x_s = fft(x)

y_s = h_s .* x_s    # 时域卷积等价于频域相乘
y = ifft(y_s)       # 反快速傅里叶IFFT

subplot(1,2,2)      # 绘制散点图
stem(y)
title("频域求解线性卷积")
