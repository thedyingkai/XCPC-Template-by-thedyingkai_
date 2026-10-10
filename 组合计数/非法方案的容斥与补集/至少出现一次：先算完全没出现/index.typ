#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("至少出现一次：先算完全没出现")] <trick-math-17>
*问题概述*　#text("给定 ")$n≥0$#text("、")$k≥0$#text("，求长度 ")$n$#text(" 的有序字符串个数，字符来自 ")$k$#text(" 个有标签符号，且每种符号至少出现一次。位置与符号都可区分；")$n=k=0$#text(" 时唯一空串合法，")$k=0$#text(" 且 n>0 时无方案。")

*必要思路*　#text("容斥缺失符号，答案 ")$sum _(j=0)^k(-1)^j binom(k,j)(k-j)^n$#text("。符号与位置都可区分。")$n=0$#text(" 时 ")$0^0$#text(" 在此代表唯一空映射，按计数语义取 1，避免代码默认不一致。")

*参考*　#link("https://cp-algorithms.com/combinatorics/inclusion-exclusion.html")[#text("CP-Algorithms：容斥原理")]。



]
