#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("恰好 K 种=至多 K 种-至多 K-1 种")] <trick-misc-04>
*问题概述*　#text("给定任意可比较值数组和整数 ")$K≥0$#text("，求恰包含 ")$K$#text(" 种不同值的非空连续子数组个数。重复值只增加出现次数，不增加种类；")$K=0$#text(" 时答案为 0，不计空区间。")

*必要思路*　#text("令 ")$F(K)$#text(" 为至多 ")$K$#text(" 种的子数组数，用窗口维护最小合法左端 ")$l$#text("，每个右端贡献 ")$r-l+1$#text("，答案 ")$F(K)-F(K-1)$#text("。")$K=0$#text(" 时非空子数组答案 0。此减法适用于嵌套阈值条件，不只不同值。")

*参考*　#link("https://oi-wiki.org/misc/two-pointer/")[#text("OI Wiki：双指针")]。



]
