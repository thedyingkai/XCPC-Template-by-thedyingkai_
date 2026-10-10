#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("平均／比例最优转判定")] <trick-misc-10>
*问题概述*　#text("给定 ")$n$#text(" 个对象的整数 ")$a_i$#text("、正数 ")$b_i$#text("，以及 ")$1≤k≤n$#text("，恰选 ")$k$#text(" 个不同下标，最大化 ")$( sum  a_i)/( sum  b_i)$#text("。除选择个数外无其他约束，分母保证正；求值精度由题目给定。")

*必要思路*　#text("试值 λ，检查是否存在合法选择使 ")$sum (a-λ b)≥0$#text("；检查方式由集合约束决定，可排序、DP 或图模型。分母非正会破坏等价，浮点二分需指定误差。恰取 ")$k$#text(" 项时取变换值最大的 ")$k$#text(" 项。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
