#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("状态维度交换：按价值记最小重量")] <trick-dp-01>
*问题概述*　#text("给定 ")$n$#text(" 件物品，第 ")$i$#text(" 件重量为非负整数 ")$w_i$#text("、价值为非负整数 ")$v_i$#text("，每件至多选一次。背包容量为 ")$C$#text("，允许不装满，求所选物品总重量不超过 ")$C$#text(" 时的最大总价值；适用规模是 ")$C$#text(" 很大而 ")$V= sum  v_i$#text(" 可枚举。")

*必要思路*　#text("令 ")$op("dp")_(v)$#text(" 为取得价值 ")$v$#text(" 的最小重量，初始 ")$op("dp")_(0)=0$#text("，其余为 INF；每个物品倒序更新价值。最终找 ")$op("dp")_(v)≤$#text("容量的最大 ")$v$#text("。复杂度 ")$O(n  sum  v)$#text("，要求价值为非负整数。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/knapsack.html")[#text("CP-Algorithms：背包")]。



]
