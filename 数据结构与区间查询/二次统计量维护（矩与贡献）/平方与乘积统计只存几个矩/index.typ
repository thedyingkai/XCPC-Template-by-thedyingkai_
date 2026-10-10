#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("平方与乘积统计只存几个矩")] <trick-misc-33>
*问题概述*　#text("给定固定 ")$n$#text(" 个数，支持把全部元素同时加整数 ")$d$#text("，并查询它们的平方和 ")$sum  a_i^2$#text("，也可同时查询元素和。每次加法使用操作前的数值；要求每次 ")$O(1)$#text(" 更新摘要，结果和中间项均需用足够宽的类型。")

*必要思路*　#text("维护数量 ")$c$#text("、和 ")$S$#text("、平方和 ")$Q$#text("，更新 ")$Q$#text("'")$=Q+2d S+c d^2$#text("、")$S$#text("'")$=S+c d$#text("，右侧 ")$S$#text(" 用旧值。由展开 ")$(x+d)^2$#text(" 求和得到。乘法与常数先扩宽；更高次可维护更多矩，但每次更新成本随次数增长。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
