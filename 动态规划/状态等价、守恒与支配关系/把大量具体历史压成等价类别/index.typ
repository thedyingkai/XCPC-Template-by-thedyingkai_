#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("把大量具体历史压成等价类别")] <trick-dp-04>
*问题概述*　#text("给定 ")$n$#text(" 天、")$m$#text(" 类活动及收益 ")$w_(i,j)$#text("，每天必须选择一类活动，且相邻两天不能选择同一类。求 ")$n$#text(" 天总收益的最大值；除这条相邻约束外，收益不依赖历史选择。")

*必要思路*　#text("未来只关心上一天活动的类别，不关心更早历史，记 ")$op("dp")_(i,op("last"))$#text(" 即可。更一般地，两个历史若对所有未来具有相同合法转移与增量贡献，就能合并。必须能证明这种未来等价，而非凭状态值相近合并。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。



]
