#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("互质筛选：莫比乌斯把 gcd=1 拆开")] <trick-math-13>
*问题概述*　#text("给定正整数 ")$N$#text("、")$M$#text("，统计有序整数对 (a,b)，满足 ")$1≤a≤N$#text("、")$1≤b≤M$#text(" 且 ")$gcd(a,b)=1$#text("。")$a=b=1$#text(" 属于合法对；当 ")$N=M$#text(" 时 (a,b) 与 (b,a) 仍按有序对区分。")

*必要思路*　#text("用 ")$[gcd(a,b)=1]= sum _(d|a,d|b)μ(d)$#text("，把答案转为按共同约数求和。")$1 dots.h N$#text("、")$1 dots.h M$#text(" 的有序对是 ")$sum μ(d)floor(N/d)floor(M/d)$#text("。任意多重集合需按倍数频次计算，并区分同下标、顺序与重复值。")

*参考*　#link("https://oi-wiki.org/math/number-theory/mobius/")[#text("OI Wiki：莫比乌斯反演")]。



]
