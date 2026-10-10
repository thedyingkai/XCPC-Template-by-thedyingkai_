#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("不区分旋转：平均固定方案")] <trick-math-22>
*问题概述*　#text("给定 ")$n≥1$#text(" 个环上位置和 ")$k≥1$#text(" 种有标签颜色，每处恰染一种颜色、无其他限制。两种染色若能通过旋转互相得到则视为同一方案，反射不自动视为等价。求旋转等价类数，不能直接用 ")$k^n/n$#text("。")

*必要思路*　#text("设 ")$G$#text(" 为位置上的旋转群，Burnside 给出等价类数")$=(1/|G|) sum _(g∈G)op("Fix")(g)$#text("。设旋转 ")$g$#text(" 有 ")$c_g$#text(" 个位置循环；不限制各色数量时，")$op("Fix")(g)=k^(c_g)$#text("，因为同一循环内颜色必须相同。群若包含反射则需另统计反射固定方案；模数下平均必须正确处理整除。")

*参考*　#link("https://cp-algorithms.com/combinatorics/burnside.html")[#text("CP-Algorithms：Burnside 引理")]。



]
