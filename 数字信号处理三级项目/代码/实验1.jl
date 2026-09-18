using TySignalProcessing
using TyBase
using TyMath
using TyPlot

x = -64:1:64
half_len = Int64(floor(length(x)/2)) - 1
q_dct = zeros(Float64, half_len)
q_fft = zeros(Float64, half_len)

### dct ###
for i = 1:2:Int64(floor(length(x)/2)) - 2
    x_1 = dct(x)
    x_1[i:end].= 0
    xs_1 = idct(x_1)
    q_dct[i] = norm(xs_1 - x)
end

subplot(1,2,1)
plot(q_dct)
title("离散余弦变换（DCT）压缩")
xlabel("保留点数");ylabel("误差")

### fft ###
for i = 1:half_len
    x_2 = fft(x)
    x_2[(i+1):(length(x)-i)] .= 0
    xs_2 = ifft(x_2)
    q_fft[i] = norm(xs_2 - x)
end

subplot(1,2,2)
plot(q_fft)
title("离散傅里叶变换（FFT）压缩")
xlabel("保留点数");ylabel("误差")