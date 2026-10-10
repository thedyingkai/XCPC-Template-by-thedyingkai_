#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("约数贡献交换求和")] <trick-math-09>
*问题概述*　#text("给定正整数 ")$N$#text("，τ(x) 为 ")$x$#text(" 的正约数个数、σ(x) 为正约数之和。分别求 ")$sum _(x=1)^N τ(x)$#text(" 和 ")$sum _(x=1)^N σ(x)$#text("，不逐个对 ")$x$#text(" 进行质因数分解，且约数均按正整数计入。")

*必要思路*　#text("每个 ")$d$#text(" 为所有 ")$d$#text(" 的倍数贡献一次，")$sum _(x≤N)τ(x)= sum _(d≤N)floor(N/d)$#text("。约数和同理变 ")$sum  d floor(N/d)$#text("，可用整除分块及等差数列区间和。先按“一个约数出现在哪些数中”统计。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/divisors.html")[#text("CP-Algorithms：约数个数与约数和")]。



]
