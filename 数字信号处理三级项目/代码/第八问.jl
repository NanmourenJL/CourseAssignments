using TySignalProcessing
using TyMath
using TyPlot 

a=[(5+sqrt(5))/10,-sqrt(5)/5,(5+sqrt(5))/10]    # 数字滤波器分子部分
b=[1]                                           # 数字滤波器分母部分
h,f = freqz(a,b,512,300)        # 得到512个采样点下采样速率为300Hz数字滤波器的频率响应向量h和相应的频率向量f
plot(f,20*log10.(abs.(h)))      # 绘制频率响应曲线
xlabel("归一化数字频率f0/Hz")    # 给出x轴标题
ylabel("幅度/dB")               # 给出y轴标题
