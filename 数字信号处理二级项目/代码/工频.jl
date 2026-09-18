using TyMath
using TyPlot

function rand_get(min_a,max_a)
    r = min_a + (max_a-min_a)*rand()
    return r
end

function sine_get(A,f,phase,N,delta)
    t=0:delta:delta*(N-1);
    y=A.*sin.(2*pi*f*t.+phase)
    return y
end
# 定义采样参数
N=200
delta=0.001
t=0:delta:delta*(N-1);

# 定义真实信号和噪声信号
global input_signal
global real_signal
real_signal = sine_get(rand_get(1,2),rand_get(0.5,4 ),rand_get(0,2*pi),N,delta)+ #δ波
              sine_get(rand_get(1,2),rand_get(  4,8 ),rand_get(0,2*pi),N,delta)+ #θ波
              sine_get(rand_get(1,2),rand_get(  8,13),rand_get(0,2*pi),N,delta)+ #α波
              sine_get(rand_get(1,2),rand_get( 13,30),rand_get(0,2*pi),N,delta)  #β波
noice_signal=sine_get(1,50,rand_get(0,2*pi),N,delta)#.*rand(N)                   #噪声信号
input_signal= noice_signal+real_signal

### IIR数字滤波器  ###
global filtered_signal
global iir_sum,iir_lms
filtered_signal=zeros(length(input_signal))
iir_sum=zeros(length(input_signal))
iir_sum[1]=(real_signal[1]*real_signal[1])
iir_sum[2]=(real_signal[2]*real_signal[2])
for i in 3:length(input_signal)
    filtered_signal[i] = 0.9693input_signal[i,] - 
                        1.8730input_signal[i-1,] + 
                        0.9693input_signal[i-2,] +
                        1.8730filtered_signal[i-1] - 
                        0.9386filtered_signal[i-2]
    iir_sum[i]=(filtered_signal[i]-real_signal[i])*(filtered_signal[i]-real_signal[i])
end
iir_lms=sqrt.(iir_sum)

### 自适应数字滤波器 ###
global filter1_para,filter2_para
global x1,x2
global filtered_sign
global iir_s,iir_l
global mu
mu=0.01                 #自适应步长
filter1_para=zeros(3)   #自适应滤波器1的权系数
filter2_para=zeros(3)   #自适应滤波器2的权系数
x1=sin.(2*pi*50*t)      #自适应滤波器1的输入信号
x2=cos.(2*pi*50*t)      #自适应滤波器2的输入信号
filtered_sign=zeros(length(input_signal))
iir_s=zeros(length(input_signal))   #滤波后信号的方差值
iir_s[1]=(real_signal[1]*real_signal[1])
iir_s[2]=(real_signal[2]*real_signal[2])
for i in 3:length(input_signal)
    y1=0;y2=0
    for j in 1:3
        y1=y1+filter1_para[j]*x1[i-j+1,]    #使用自适应滤波器1对输入信号滤波
        y2=y2+filter2_para[j]*x2[i-j+1,]    #使用自适应滤波器2对输入信号滤波
    end
    filtered_sign[i]=input_signal[i,]-y1-y2 #计算误差值
    for j in 1:3                            #迭代自适应滤波器权系数
        filter1_para[j]=filter1_para[j]+2*mu*filtered_sign[i]*x1[i,]    
        filter2_para[j]=filter2_para[j]+2*mu*filtered_sign[i]*x2[i,]
    end                                     #计算各个信号方差值
    iir_s[i]=(filtered_sign[i]-real_signal[i])*(filtered_sign[i]-real_signal[i])
end
iir_l=sqrt.(iir_s)                          #计算各个信号均方差

plot(t,iir_lms,t,iir_l)
# legend(["iir_lms", "iir_l"])
plot(t,real_signal,t,input_signal,t,filtered_signal,t,filtered_sign)
legend(["实际信号", "含噪信号","IIR滤波器输出信号","自适应滤波器输出信号"])

grid("on")

