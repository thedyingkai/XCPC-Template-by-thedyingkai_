#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("取整区间反推分母范围")] <trick-math-33>
*问题概述*　#text("给定 ")$N≥0$#text("、整数 ")$q≥0$#text(" 及有限正整数区间 [L,R]，求全部满足 ")$floor(N/x)=q$#text(" 的整数 ")$x$#text("，或者其数量。")$q=0$#text(" 也需处理，此时条件为 x>N；")$x=0$#text(" 不属于合法分母。")

*必要思路*　#text("q>0 时 ")$x∈[floor(N/(q+1))+1,floor(N/q)]$#text("，再与题目区间取交。")$q=0$#text(" 时是 x>N，没有有限右端。反过来枚举少量商，可避开巨大分母范围。自行推导。")

*参考*　#link("https://oi-wiki.org/math/number-theory/sqrt-decomposition/")[#text("OI Wiki：数论分块")]。



]
