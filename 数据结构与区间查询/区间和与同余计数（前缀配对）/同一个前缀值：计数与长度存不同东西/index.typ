#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("同一个前缀值：计数与长度存不同东西")] <trick-misc-03>
*问题概述*　#text("给定整数数组及目标 ")$K$#text("，分别求和恰为 ")$K$#text(" 的非空连续子数组数量、最长长度或最短长度。数组允许负数，端点不同视为不同区间；长度目标无合法区间时返回无解，三种目标需要不同的前缀摘要。")

*必要思路*　#text("")$p_(l-1)=p_(r)-K$#text("。求数量存出现次数；求最长存最早位置；求最短存最近位置。先查询再插入当前前缀，以免产生空区间。若要求长度至少 ")$L$#text("，要只加入已经满足距离的前缀。自行归纳。")

*参考*　#link("https://oi-wiki.org/basic/prefix-sum/")[#text("OI Wiki：前缀和与差分")]。



]
