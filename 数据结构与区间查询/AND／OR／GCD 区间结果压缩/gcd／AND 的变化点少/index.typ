#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("gcd／AND 的变化点少")] <trick-math-10>
*问题概述*　#text("给定非负整数数组及目标 ")$g≥0$#text("，统计 ")$gcd(a_l,…,a_r)=g$#text(" 的非空连续子数组个数。规定 ")$gcd(0,…,0)=0$#text("，不同端点对分别计数；要求压缩固定右端点的不同 gcd 与对应次数。")

*必要思路*　#text("对固定右端点保留不同 gcd 与次数，新数加入时对每个旧 gcd 再 gcd 一次并合并。正 gcd 每次严格下降就至少减半，因此仅 ")$O(log V)$#text(" 种（0 单独计）；总约 ")$O(n log V)$#text(" 次 gcd 运算，其内部成本另算。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/euclid-algorithm.html")[#text("CP-Algorithms：欧几里得算法")]。



]
