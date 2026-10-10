#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("背包循环顺序本身就是约束")] <trick-dp-10>
*问题概述*　#text("给定物品重量 ")$w_i>0$#text("、价值 ")$v_i$#text(" 和容量 ")$K$#text("，分别考虑每件至多取一次、每类可无限次取、同一组至多取一件三种模型。各模型均求重量不超过 ")$K$#text(" 的最大价值，要求用一维容量数组实现且严格遵守各自使用次数约束。")

*必要思路*　#text("")$0/1$#text(" 背包容量倒序，让右侧读取旧层；完全背包正序，让新状态继续使用当前物品。分组背包读旧组，不能把同组不同物品串起来。若重量为 0，须单独分析，不能机械套循环。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/knapsack.html")[#text("CP-Algorithms：背包")]。



]
