#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("组合选择替代复杂求和")] <trick-math-14>
*问题概述*　#text("给定非负整数 a,b,r，求 ")$sum _k binom(a,k) binom(b,r-k)$#text("，其中 ")$binom(u,v)$#text(" 在 v<0 或 v>u 时定义为 0，求和包含全部合法 ")$k$#text("。目标是在求值之前识别整个求和的组合意义，不能额外截断 ")$k$#text(" 的范围。")

*必要思路*　#text("把 ")$a+b$#text(" 个对象分两类，选 ")$r$#text(" 个；按第一类选 ")$k$#text(" 个分类便得 ")$binom(a+b,r)$#text("。这也是范德蒙德恒等式的组合证明。上下界被截断时只算完整合法 ")$k$#text("；任意加权系数不一定还能直接合并。")

*参考*　#link("https://cp-algorithms.com/combinatorics/binomial-coefficients.html")[#text("CP-Algorithms：二项式系数")]。



]
