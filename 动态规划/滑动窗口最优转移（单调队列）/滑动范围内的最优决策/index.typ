#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("滑动范围内的最优决策")] <trick-dp-08>
*问题概述*　#text("给定初值 ")$op("dp")_0$#text("、数组 ")$c_i$#text("、")$b_i$#text("，以及整数端点 ")$L_i$#text("、")$R_i$#text("；满足 ")$0≤L_i≤R_i<i$#text("，且 ")$L_i$#text("、")$R_i$#text(" 都随 ")$i$#text(" 非降。按 ")$i$#text(" 递增计算 ")$op("dp")_i=c_i+min_(L_i≤j≤R_i)(op("dp")_j+b_j)$#text("，目标是在线性时间内完成全部转移。")

*必要思路*　#text("把 ")$op("dp")_(j)+b_(j)$#text(" 存入单调队列，新决策按值淘汰不可能再优的旧决策，窗口左边界到达时弹出过期项。仅当加入顺序及过期顺序可维护时成立；窗口乱跳不能直接用。该式是单调队列模型的自行推导。")

*参考*　#link("https://cp-algorithms.com/data_structures/stack_queue_modification.html")[#text("CP-Algorithms：双栈与最小队列")]。



]
