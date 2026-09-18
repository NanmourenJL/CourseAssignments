using TyBase
using TyPlot
using TySignalProcessing

file_path = joinpath(@__DIR__, "原始数据.csv")
M1 = csvread(file_path)

sgf1 = sgolayfilt(M1,3,53)

output=M1-sgf1

subplot(3,1,1)
plot(M1)
title("原始信号")
subplot(3,1,2)
plot(sgf1)
title("基线估计（Savitzky-Golay滤波）")
subplot(3,1,3)
plot(output)
title("基线校正后信号")