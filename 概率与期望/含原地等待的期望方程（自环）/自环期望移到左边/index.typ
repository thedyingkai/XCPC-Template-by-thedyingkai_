#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("自环期望移到左边")] <trick-dp-18>
*问题概述*　#text("给定有限随机状态过程，终止状态到达后不再行动。非终止状态 ")$s$#text(" 每步耗时 1，以概率 ")$p_s<1$#text(" 留在原状态，以概率 ")$q_(s,t)$#text(" 进入拓扑顺序更早的状态 ")$t$#text("，且 ")$p_s+ sum  q_(s,t)=1$#text("。求从指定状态出发到终止的期望步数。")

*必要思路*　#text("")$E=1+p E+ sum  q_i E_i$#text("，故 ")$E=(1+ sum  q_i E_i)/(1-p)$#text("。先消去自环再递推；")$p=1$#text(" 且无终止机会时，期望可能无穷。有多状态环通常要联立方程，不能只消掉自己的自环。")

*参考*　#link("https://www.luogu.com/article/ms32f221")[#text("洛谷：概率和期望")]。


参见 #link(<book-linear-system>)[一般线性期望方程的高斯消元]。

参见 #link(<book-geometric-probability>)[随机方向、边界、区域点与重叠面积的几何模型]。

#pagebreak()


]
