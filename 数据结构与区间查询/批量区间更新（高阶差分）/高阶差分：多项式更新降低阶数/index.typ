#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("高阶差分：多项式更新降低阶数")] <trick-misc-18>
*问题概述*　#text("给定长度 ")$n$#text(" 的整数数组及若干离线更新 (l,r,P)，")$P(i)$#text(" 是次数至多 ")$d$#text(" 的已知多项式。每次把 [l,r] 的 ")$a_i$#text(" 加上 ")$P(i)$#text("，区间外不变；全部更新结束后输出每点最终值，")$d$#text(" 是小常数，不要求中途在线查询。")

*必要思路*　#text("常数更新用一阶差分两个边界；线性用二阶差分、")$d$#text(" 次多项式用 ")$d+1$#text(" 阶差分，只改 ")$O(d)$#text(" 个边界附近项，再前缀还原。边界值需按有限差分实际推导，不能只把端点代入一次；在线查询还需相应数据结构。")

*参考*　#link("https://oi-wiki.org/basic/prefix-sum/")[#text("OI Wiki：前缀和与差分")]。



]
