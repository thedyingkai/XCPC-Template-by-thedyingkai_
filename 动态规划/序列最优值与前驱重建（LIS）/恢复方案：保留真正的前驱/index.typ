#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("恢复方案：保留真正的前驱")] <trick-dp-34>
*问题概述*　#text("给定 ")$n$#text(" 件物品，重量 ")$w_i≥0$#text("、价值 ")$v_i$#text("，每件至多选择一次，容量 ")$K$#text("。除求最大总价值外，还要输出一组达到最优值的原物品编号，每个编号最多出现一次；使用滚动 DP 时也必须保证重建链指向真实历史状态。")

*必要思路*　#text("每次最优值更新记录来源；滚动数组时不能让前驱引用后来被覆盖的状态，可保留分层前驱或不变节点。LIS 用原位置与 predecessor 链恢复，不能直接输出 tails。计数任务还须规定同值选哪个前驱。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/longest_increasing_subsequence.html")[#text("CP-Algorithms：最长上升子序列")]。



]
