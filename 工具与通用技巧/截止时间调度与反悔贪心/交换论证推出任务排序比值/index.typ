#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("交换论证推出任务排序比值")] <trick-misc-15>
*问题概述*　#text("给定 ")$n$#text(" 个单机任务，处理时长 ")$t_i≥0$#text("、权重 ")$w_i>0$#text("，全部在时刻 0 可开始，无依赖及释放时间。必须全部执行且不可抢占，任务 ")$i$#text(" 的完成时刻为 ")$C_i$#text("，求使 ")$sum  w_i C_i$#text(" 最小的执行顺序。")

*必要思路*　#text("比较相邻 ")$i$#text("、")$j$#text(" 两种顺序，")$i$#text("在前优于")$j$#text("在前当且仅当 ")$t_(i)w_(j)≤t_(j)w_(i)$#text("，按 ")$t/w$#text(" 升序。交叉乘积避免浮点误差，先扩宽。任务有优先依赖或释放时间时，相邻交换可能不合法。")

*参考*　#link("https://cp-algorithms.com/schedules/schedule_one_machine.html")[#text("CP-Algorithms：单机任务调度")]。



]
