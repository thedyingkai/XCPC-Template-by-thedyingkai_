#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("固定中间元素统计三元组")] <trick-misc-02>
*问题概述*　#text("给定整数序列 ")$a_1…a_n$#text("，统计下标三元组 i<j<k 且 ")$a_i<a_j<a_k$#text(" 的个数，所有不等式严格，重复数值不能形成严格上升。目标计数按下标区分，不要求三个元素在数组中相邻。")

*必要思路*　#text("固定 ")$j$#text("，数左侧严格更小 ")$L_(j)$#text("、右侧严格更大 ")$R_(j)$#text("，贡献 ")$L_(j)R_(j)$#text("，两遍扫描配树状数组。左右条件在固定 ")$j$#text(" 后独立，所以能相乘；若还有 ")$i$#text("、")$k$#text(" 间约束，必须保留额外信息。自行推导。")

*参考*　#link("https://cp-algorithms.com/data_structures/fenwick.html")[#text("CP-Algorithms：树状数组")]。



]
