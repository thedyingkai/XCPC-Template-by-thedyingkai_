#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("整除分块：相同商一段算")] <trick-math-07>
*问题概述*　#text("给定非负整数 ")$N$#text("、范围 ")$1≤L≤R$#text("，以及权函数 ")$f$#text(" 的区间和查询接口，求 ")$sum _(i=L)^R f(i) floor(N/i)$#text("。希望只处理商不变的连续分母段；i>N 时商为 0，区间可能包含这样的尾段。")

*必要思路*　#text("从 ")$l$#text(" 开始，")$q=N/l$#text("，相同商的右端 ")$r=N/q$#text("（再截到查询上界），整块加 ")$q  sum _(i=l)^r f(i)$#text("。不同正商仅 ")$O(sqrt(N))$#text(" 个；")$q=0$#text(" 时不能再 ")$N/q$#text("，要单独处理剩余尾段。")

*参考*　#link("https://oi-wiki.org/math/number-theory/sqrt-decomposition/")[#text("OI Wiki：数论分块")]。



]
