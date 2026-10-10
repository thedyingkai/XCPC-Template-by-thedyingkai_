#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("截止时间反悔：删掉最长工作")] <trick-misc-14>
*问题概述*　#text("给定 ")$n$#text(" 个单机任务，第 ")$i$#text(" 个时长 ")$t_i>0$#text("、截止时间 ")$d_i≥0$#text("。所有任务在时刻 0 可开始，可任意排序或舍弃，执行不可抢占，完成时刻不超过截止时间才算按期。求最多能按期完成多少任务，任务没有不同收益。")

*必要思路*　#text("按截止时间升序，加入工作并累计时间；若超过当前截止，弹出已选最长时长。这样同样任务数下尽量保留更短总时间，给未来留空间。目标是任务数且无释放时间，带不同收益时不能照搬。")

*参考*　#link("https://www.luogu.com.cn/article/ip2rnlsd")[#text("洛谷：二叉堆与反悔调度")]。



]
