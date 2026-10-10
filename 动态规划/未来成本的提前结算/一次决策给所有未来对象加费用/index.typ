#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("一次决策给所有未来对象加费用")] <trick-dp-06>
*问题概述*　#text("给定顺序固定的 ")$n$#text(" 个任务，处理时长 ")$t_i≥0$#text("、权重 ")$f_i≥0$#text("。把任务划分为若干非空连续批次，单机依次处理；每批先耗启动时间 ")$S≥0$#text("，再处理该批任务，同批所有任务的完成时刻均为该批结束时刻。求 ")$sum  f_i C_i$#text(" 的最小值，允许自行决定批次边界。")

*必要思路*　#text("启动一次会让全部尚未完成任务多等 ")$S$#text("，把 ")$S$#text("剩余权重和立即计入当前决策。这样可省掉“已分多少批”维度。只适用于本次对未来的影响已确定；影响还依赖未来选择时，要保留必要状态。")

*参考*　#link("https://www.luogu.com.cn/article/bvovtmzp")[#text("洛谷 LgxTpre：费用提前计算")]。



]
