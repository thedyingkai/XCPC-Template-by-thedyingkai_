#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("模小质数的组合数按位拆")] <trick-math-18>
*问题概述*　#text("给定非负整数 ")$n$#text("、")$k$#text(" 和质数 ")$p$#text("，求 ")$binom(n,k) mod p$#text("，k>n 时为 0。")$n$#text(" 可以远大于 ")$p$#text("，")$p$#text(" 必须小到能承担 ")$0…p-1$#text(" 的预处理；不允许把这个前提替换为任意复合模数。")

*必要思路*　#text("Lucas：把 ")$n$#text("、")$k$#text(" 写成 ")$p$#text(" 进制，")$binom(n,k)≡ product  C(n_i,k_i) mod p$#text("；某位 ")$k_i>n_i$#text(" 即为 0。预处理 ")$0 dots.h p-1$#text(" 的组合值/阶乘，")$p$#text(" 大时仍可能内存不可承受。复合模不能直接套。")

*参考*　#link("https://cp-algorithms.com/combinatorics/binomial-coefficients.html")[#text("CP-Algorithms：二项式系数")]。



]
