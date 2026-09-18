using TyDSPSystem
using TyPlot
using TySignalProcessing
import TyTimeSeries
using TyBase
using TyMath
using TyPlot

pkg_dir = pkgdir(TyDSPSystem)
fi = joinpath(@__DIR__, "data.wav")
afr = dsp_AudioFileReader(Filename=fi, SamplesPerFrame=146432)
y = step(afr)

N = length(y)
f = (0:N/2-1) * afr.SampleRate / N
noisy_fft = abs.(fft(y))

www, locs = findpeaks(noisy_fft[1:Int64(N/2)]; SortStr="descend")
f_noise = f[locs[1]]

fo = f_noise
bw = 50
wo = bw / (afr.SampleRate / 2)
bw_wo = fo / (afr.SampleRate / 2)

b, a = iirnotch(wo, bw_wo)
filtered_voice = filtfilt(b, a, y)

figure()
subplot(2, 1, 1)
plot(f, noisy_fft[1:Int64(N/2)])
title("原始信号频谱")

subplot(2, 1, 2)
filtered_fft = abs.(fft(filtered_voice))
plot(f, filtered_fft[1:Int64(N/2)])
title("滤波信号频谱")
