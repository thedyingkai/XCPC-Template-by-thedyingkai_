#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("恰有 k 个固定点与错排")] <trick-math-20>
*问题概述*　#text("给定 ")$0≤k≤n$#text("，求 1…n 的排列中恰有 ")$k$#text(" 个固定点的数量，固定点是满足 ")$p_i=i$#text(" 的下标。剩余 n-k 个位置都必须不是固定点；")$n=0,k=0$#text(" 计唯一空排列。")

*必要思路*　#text("先选固定位置 ")$binom(n,k)$#text("，剩下必须全部错排，乘 ")$D(n-k)$#text("。")$D(0)=1$#text("、")$D(1)=0$#text("，")$D(n)=(n-1)(D(n-1)+D(n-2))$#text("。不能让剩余部分又有固定点，否则变成至少 ")$k$#text(" 个。")

*参考*　#link("https://oi-wiki.org/math/combinatorics/derangement/")[#text("OI Wiki：错位排列")]。



]
