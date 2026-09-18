using TyBase        # 调用同元基础库
using TyMath        # 调用同元数学库
using TyPlot        # 调用同元绘图库
using CSV           # 调用CSV读取库

function shock_response(a::Float64,x::Vector)   # 定义响应解算函数
    h=zeros(length(x))                          # 定义冲激响应h(n)的长度
    for i in 1:length(x)                        # 求解h(n)
        h[i]=power(a,i)                         
    end
    return conv(h,x)                            # 返回卷积结果
end

file_path = joinpath(@__DIR__, "某指数月度历史数据.csv") # 生成文件绝对路径
table = DataFrame(CSV.File(file_path));                # 读取表格
x = table[:,2]                  # 取出文件第二列作为有限序列x(n) 

for i in 1:9                            # 共绘制9幅图
    subplot(3,3,i)                      # 第i张图绘制在3行3列的第i个位置
    a=i*0.2-1                           # 第i张图取对应a值（相当于a=-0.8:0.2:0.8）
    y=shock_response(a,x)               # 调用响应解算函数shock_response（）
    plot(y)                             # 绘制响应曲线
    title("a="*@sprintf("%.1f", a))     # 生成图名
end

