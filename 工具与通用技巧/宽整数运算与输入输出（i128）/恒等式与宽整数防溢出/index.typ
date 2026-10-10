#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("恒等式与宽整数防溢出")] <trick-math-36>
*问题概述*　#text("输入整数范围保证最终答案或比较结果可表示，但直接乘法可能溢出 64 位。典型任务为正整数 a,b 的 lcm、整数闭区间 [l,r] 的等差和，以及分母为正的两个有理数大小比较；要求给出不截断中间值的精确计算方式。")

*必要思路*　#text("")$lcm(a,b)=a/gcd(a,b)*b$#text("，先除再乘。等差和先在 128 位中计算 ")$l+r$#text(" 与 ")$r-l+1$#text("，再把其中的偶因子除 2 后相乘；最终和能放进 64 位，也不保证端点和或区间长度能放进 64 位。比较 ")$a/b$#text(" 与 ")$c/d$#text("（b,d>0）用 128 位交叉乘积，负分母先归一化。C++ 必须在运算前转换操作数，不能先用 64 位计算再赋给 128 位变量；最终转回目标类型前检查范围。")

*参考*　#link("https://cp-algorithms.com/algebra/euclid-algorithm.html")[#text("CP-Algorithms：欧几里得算法")]。



]
