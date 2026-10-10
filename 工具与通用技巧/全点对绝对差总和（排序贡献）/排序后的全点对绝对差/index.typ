#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("排序后的全点对绝对差")] <trick-misc-34>
*问题概述*　#text("给定 ")$n$#text(" 个整数 ")$a_i$#text("，求 ")$sum _(1≤i<j≤n)|a_i-a_j|$#text("。允许负数和重复值，不同下标无序对各计一次，n<2 时为 0；目标是算术总和而不是最大或最小数对距离。")

*必要思路*　#text("排序后，第 ")$i$#text(" 项作为较大者贡献 ")$i*a_(i)-$#text("此前前缀和（下标从 0）。累加即可 ")$O(n log n)$#text("。负数和重复值都允许，乘法用宽类型；多维 Manhattan 和可按每个坐标独立做，但 Euclidean 距离不行。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
