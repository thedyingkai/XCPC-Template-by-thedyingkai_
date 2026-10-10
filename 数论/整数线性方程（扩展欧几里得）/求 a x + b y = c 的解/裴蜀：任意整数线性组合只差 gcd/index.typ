#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("裴蜀：任意整数线性组合只差 gcd")] <trick-math-02>
*问题概述*　#text("从整数坐标 0 出发，每次可以选择给定非负整数长度 ")$a_i$#text("，向左或向右移动该长度；每种长度可无限次使用。给定整数目标 ")$D$#text("，判断能否经过有限步恰到 ")$D$#text("；允许所有 ")$a_i$#text(" 都为 0，位置没有额外边界。")

*必要思路*　#text("可达整数集合恰为所有长度 gcd 的倍数，所以检查 gcd|D。允许负系数是关键；若每种只能用非负次数或次数有限，这个条件通常只必要不充分。全零长度时只有 ")$D=0$#text(" 可达。")

*参考*　#link("https://cp-algorithms.com/algebra/linear-diophantine-equation.html")[#text("CP-Algorithms：不定方程")]。



]
