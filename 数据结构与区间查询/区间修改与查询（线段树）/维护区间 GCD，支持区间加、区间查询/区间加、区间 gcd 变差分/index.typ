#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("区间加、区间 gcd 变差分")] <trick-math-11>
*问题概述*　#text("给定整数数组，支持区间加操作：把 [l,r] 中每个 ")$a_i$#text(" 加上整数 ")$d$#text("；查询返回 ")$gcd(|a_l|,…,|a_r|)$#text("。数组与增量均可为负，区间非空，单点查询返回该元素绝对值。")

*必要思路*　#text("设 ")$d_(i)=a_(i)-a_(i-1)$#text("，")$gcd(a_(l dots.h r))=gcd(a_(l),d_(l+1 dots.h r))$#text("。区间加仅修改 ")$d_(l)$#text(" 与 ")$d_(r+1)$#text("；用树状数组取 ")$a_(l)$#text("，线段树查差分 gcd。差分取绝对值，")$l=r$#text(" 时空差分 ")$gcd=0$#text("。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/euclid-algorithm.html")[#text("CP-Algorithms：欧几里得算法")]。



]
