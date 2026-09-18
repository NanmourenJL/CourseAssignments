using TySignalProcessing
using TyMath
using TyPlot 

# 定义频率响应绘图函数plot_freqz，其中w为窗函数采样点，i为子图数
function plot_freqz(w,i)
    h,a=freqz(w)                    # 得到512个采样点下频率响应向量h和相应的频率向量f
    subplot(2,4,i)                  # 在第i张子图上绘制
    plot(a/pi,20*log10.(abs.(h)))   # 绘制频率响应曲线
    xlabel("归一化数字角频率")       # 给出x轴标题
    ylabel("幅度/dB")               # 给出y轴标题
end

###  矩形窗绘制部分  ###
subplot(2,4,1)                      # 在第1张子图上绘制
w = rectwin(51)                     # 给出51点的矩形窗函数波形
plot(w);title("矩形窗")             # 绘制时域波形并给出标题
plot_freqz(w,5)                     # 绘制频谱

###  三角窗绘制部分  ###
subplot(2,4,2)                      # 在第2张子图上绘制
w = triang(51)                     # 给出51点的三角窗函数波形
plot(w);title("三角窗")             # 绘制时域波形并给出标题
plot_freqz(w,6)                     # 绘制频谱

###  汉宁窗绘制部分  ###
subplot(2,4,3)                      # 在第3张子图上绘制
w = hann(51)                        # 给出51点的汉宁窗函数波形
plot(w);title("汉宁窗")             # 绘制时域波形并给出标题
plot_freqz(w,7)                     # 绘制频谱

###  汉明窗绘制部分  ###
subplot(2,4,4)                      # 在第4张子图上绘制
w = hamming(51)                     # 给出51点的汉明窗函数波形
plot(w);title("汉明窗")             # 绘制时域波形并给出标题
plot_freqz(w,8)                     # 绘制频谱
