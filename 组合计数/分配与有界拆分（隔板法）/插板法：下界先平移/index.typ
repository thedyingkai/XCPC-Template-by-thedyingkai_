#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("插板法：下界先平移")] <trick-math-15>
*问题概述*　#text("给定 ")$k≥1$#text(" 个有编号整数变量及下界 ")$l_i$#text("、总和 ")$S$#text("，求满足 ")$x_i≥l_i$#text("、")$sum  x_i=S$#text(" 的整数向量个数；每个变量没有上界，按各坐标值区分方案。")$k=0$#text(" 的特例仅在 ")$S=0$#text(" 时有一个空向量。")

*必要思路*　#text("非负解数为 ")$binom(S+k-1,k-1)$#text("；设 ")$y i=x i-l i$#text("，先把 ")$S$#text(" 减去 ")$sum  l i$#text("，若新 S<0 无解。")$k=0$#text(" 时只可能空和 0；题目对象可区分才是这类解计数。")

*参考*　#link("https://cp-algorithms.com/combinatorics/stars_and_bars.html")[#text("CP-Algorithms：插板法")]。



]
