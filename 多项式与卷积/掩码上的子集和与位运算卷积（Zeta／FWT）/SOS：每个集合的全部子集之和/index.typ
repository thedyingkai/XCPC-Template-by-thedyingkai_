#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("SOS：每个集合的全部子集之和")] <trick-bit-11>
*问题概述*　#text("给定所有 ")$n$#text(" 位掩码对应的数值 ")$f_(T)$#text("，对每个掩码 ")$S$#text(" 求 ")$F_(S)= sum _(T⊆S)f_(T)$#text("，包含空集和 ")$S$#text(" 本身。允许按模数做加法，要求总复杂度 ")$O(n 2^n)$#text("，而非为每个 ")$S$#text(" 独立枚举子集。")

*必要思路*　#text("按位做高维前缀和：第 ")$b$#text(" 位为 1 时 ")$F_(S)+=F_(S op("xor")(1 op("<<") b))$#text("，总 ")$O(n 2^n)$#text("。做超集和时反向传播；若只要找最大子集值，运算改 max。注意是逐位分阶段，不能任意一次遍历就完成全部传播。")

*参考*　#link("https://usaco.guide/plat/dp-sos")[#text("USACO Guide：SOS DP")]。



]
