#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("置换重复操作拆成环")] <trick-math-21>
*问题概述*　#text("给定 1…n 上的置换 ")$p$#text("，以及可能由长整数表示的非负次数 ")$T$#text("。把映射 ")$p$#text(" 连续作用 ")$T$#text(" 次，求每个编号 ")$x$#text(" 最终到达的 ")$(p^T)(x)$#text("；")$T=0$#text(" 时为 ")$x$#text("，输入必须是双射而非一般函数图。")

*必要思路*　#text("将置换拆为不交环。每点沿其环前进 T mod 环长次即可，已给定 ")$T$#text(" 的普通整数值时总 ")$O(n)$#text("，长串需先计算各环长的余数。一般函数图还有入环树枝，必须先处理到环距离；不能把重复作用当成循环移动整个数组。")

*参考*　#link("https://cp-algorithms.com/algebra/binary-exp.html")[#text("CP-Algorithms：快速幂")]。


参见 #link(<book-combinatorial-numbers>)[错排数与斯特林数代码]。


]
