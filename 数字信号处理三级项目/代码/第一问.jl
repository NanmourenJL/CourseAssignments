using TyMath        # 调用同元数学库
h = [2,1,0.5,0]     # 有限序列h(n)
x = [-1,0,0,1,0,2]  # 有限序列x(n)
y = conv(x,h)       # y(n)为x(n)和h(n)的线性卷积
print(y)            # 输出线性卷积序列y(n)