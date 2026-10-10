#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("有上界的插板用容斥")] <trick-math-16>
*问题概述*　#text("给定 ")$k≥1$#text("、非负整数上界 ")$u_i$#text(" 和目标 ")$S≥0$#text("，求满足 ")$0≤x_i≤u_i$#text("、")$sum  x_i=S$#text(" 的整数向量个数，变量按编号区分。若采用子集容斥，要求 ")$k$#text(" 足够小可枚举 ")$2^k$#text("；大 ")$k$#text("、小 ")$S$#text(" 应换用 DP。")

*必要思路*　#text("对超界变量集合 ")$T$#text("，用 ")$y_i=x_i-(u_i+1)$#text(" 把下界移回 0，容斥贡献为 ")$(-1)^abs(T) binom(S-sum_(i in T)(u_i+1)+k-1,k-1)$#text("。对所有 ")$T$#text(" 求和，不合法的组合数参数贡献 0。小 ")$k$#text(" 可枚举 ")$2^k$#text("；大 ")$k$#text("、小 ")$S$#text(" 采用前缀和背包。")

*参考*　#link("https://cp-algorithms.com/combinatorics/stars_and_bars.html")[#text("CP-Algorithms：插板法")]；#link("https://cp-algorithms.com/combinatorics/inclusion-exclusion.html")[#text("CP-Algorithms：容斥原理")]。



]
