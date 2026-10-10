#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("集合里已经隐含了“第几步”")] <trick-dp-21>
*问题概述*　#text("给定 ")$n$#text(" 个人、")$n$#text(" 个任务及布尔矩阵 ")$o k_(i,j)$#text("，表示第 ")$i$#text(" 人能否执行第 ")$j$#text(" 个任务。每人恰分配一个任务，每个任务恰分配一次，求合法双射的个数；人和任务均按编号区分。")

*必要思路*　#text("")$op("dp")_(S)$#text(" 记前 popcount(S) 个人已经分配给集合 ")$S$#text(" 中任务的方案数，下一人由集合大小确定，无需单独记录人数。每个未选任务检查匹配条件，")$O(n 2^n)$#text("。人与任务的顺序须固定。")

*参考*　#link("https://oi-wiki.org/dp/state/")[#text("OI Wiki：状压 DP")]。



]
