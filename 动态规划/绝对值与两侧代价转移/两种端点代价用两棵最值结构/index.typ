#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("两种端点代价用两棵最值结构")] <trick-dp-12>
*问题概述*　#text("给定任意顺序的坐标 ")$x_1…x_n$#text("、常数增量 ")$c_1…c_n$#text(" 及 ")$op("dp")_0=0$#text("、")$x_0$#text("。对 ")$i≥1$#text("，定义 ")$op("dp")_i=c_i+min_(0≤j<i)(op("dp")_j+|x_i-x_j|)$#text("。求 ")$op("dp")_n$#text("；合法前驱仅由 j<i 决定，坐标可重复，不能先按坐标重新安排计算次序。")

*必要思路*　#text("按 ")$x_j≤x_i$#text(" 和 ")$x_j≥x_i$#text(" 拆开，分别维护 ")$op("dp")_j-x_j$#text(" 的前缀最小值与 ")$op("dp")_j+x_j$#text(" 的后缀最小值。得到两侧最小值后加上 ")$c_i$#text("；坐标离散化并用线段树维护，先查询再插入，")$O(n log n)$#text("。不可达前驱跳过；若增加额外前驱限制，要同步维护。")

*依据*　自行推导/归纳，理由已写在思路中。



]
