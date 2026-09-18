using TyMath                # 调用同元数学库
using TyPlot                # 调用同元绘图库
using TySignalProcessing    # 调用同元信号处理库

x = [5,2,4,-1,2]    # 有限序列x(n)
h = [-3,4,-1]       # 有限序列h(n)

subplot(2,2,1)
y = conv(x,h)      # y(n)为x(n)和h(n)的线性卷积
stem(y)            # 输出线性卷积序列y(n)
title("线性卷积")

subplot(2,2,2)
y = cconv(x,h,6)   # y(n)为x(n)和h(n)的6点循环卷积
stem(y)            # 输出6点循环卷积序列y(n)
title("6点循环卷积")

subplot(2,2,3)
y = cconv(x,h,7)   # y(n)为x(n)和h(n)的7点循环卷积
stem(y)            # 输出7点循环卷积序列y(n)
title("7点循环卷积")

subplot(2,2,4)
y = cconv(x,h,8)   # y(n)为x(n)和h(n)的8点循环卷积
stem(y)            # 输出8点循环卷积序列y(n)
title("8点循环卷积")