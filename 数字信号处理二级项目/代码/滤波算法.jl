using TyBase
using TyPlot
using TySignalProcessing

file_path = joinpath(@__DIR__, "原始数据.csv")
M1 = csvread(file_path)

sgf1 = sgolayfilt(M1,3,53)
sgf2 = sgolayfilt(M1,9,53)
sgf3 = sgolayfilt(M1,3,25)

#hold("on")
subplot(4,1,1)
plot(M1)
title("原始信号")
subplot(4,1,2)
plot(sgf1)
title("滤波信号（阶数=3，帧长=53）")
subplot(4,1,3)
plot(sgf2)
title("滤波信号（阶数=9，帧长=53）")
subplot(4,1,4)
plot(sgf3)
title("滤波信号（阶数=3，帧长=25）")