using TyBase
using TyMath
using TyPlot

for i in 1:9            # 共绘制9幅图（数据时间长度Tp不变，皆为10）
    T=10/power(2,i+1)   # 计算第i张图的时域采样间隔为T
    t=0:T:10            # 计算各个采样点时间
    y=sin.(20*pi*t)     # 计算各个采样点采样值
    y_s=fft(y)          # 快速傅里叶变换FFT
    y_s=y_s[1:power(2,i)]       # 去除周期延拓信号
    f=0:(1/10):(power(2,i)/10)-1/10  #得到频率坐标轴
    
    subplot(3,3,i)      # 绘图
    plot(f,abs.(y_s))
    title("采样频率fs="*@sprintf("%.1f",power(2,i+1)/10))
end
