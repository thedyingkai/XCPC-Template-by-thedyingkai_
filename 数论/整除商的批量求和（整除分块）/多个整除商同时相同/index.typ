#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("多个整除商同时相同")] <trick-math-08>
*问题概述*　#text("给定非负整数 ")$N$#text("、")$M$#text("、")$1≤L≤R$#text("，且可 ")$O(1)$#text(" 求权函数 ")$w$#text(" 的区间和。求 ")$sum _(i=L)^R floor(N/i) floor(M/i) w(i)$#text("。分块内两个商都必须固定，范围可超出 min(N,M)，这部分乘积为 0。")

*必要思路*　#text("从左端 ")$l$#text(" 开始，两个商分别为 ")$q_N=floor(N/l)$#text("、")$q_M=floor(M/l)$#text("。若任一商为 0，后续乘积全为 0，可停止。否则 ")$r=min(floor(N/q_N),floor(M/q_M),R)$#text("，在 [l,r] 内同时固定两商，乘权重区间和后令 ")$l=r+1$#text("。总块数 ")$O(sqrt(N)+sqrt(M))$#text("，不对零商做除法。")

*参考*　#link("https://oi-wiki.org/math/number-theory/sqrt-decomposition/")[#text("OI Wiki：数论分块")]。



]
