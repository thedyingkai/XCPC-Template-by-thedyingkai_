#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("区间求和型转移变前缀和")] <trick-dp-07>
*问题概述*　#text("有 ")$n$#text(" 个有编号的人及 ")$K$#text(" 颗不可区分的糖。给第 ")$i$#text(" 人的糖数 ")$x_i$#text(" 必须满足 ")$0≤x_i≤a_i$#text("，所有 ")$a_i$#text("、")$K$#text(" 为非负整数。求满足 ")$sum  x_i=K$#text(" 的分配向量个数，按题目给定模数取模。")

*必要思路*　#text("")$op("dp")_(i,j)= sum  op("dp")_(i-1,j-t)$#text("，")$t∈[0,a_(i)]$#text("。前一层做前缀和，查询 ")$[max(0,j-a_(i)),j]$#text("，降至 ")$O(n K)$#text("。负下标视为 0，取模减法归一化；必须查询完整上一层。")

*实现提示*　#text("例：第 ")$i$#text(" 类最多取 ")$a_(i)$#text(" 个，求总数恰好 ")$K$#text(" 的方案数。复杂度 ")$O(n K)$#text("，滚动数组 ")$O(K)$#text("。所有加减按题目模数处理。")

*伪代码*（需结合题目接口实现）

#trick-code("old[0] = 1; old[1..K] = 0\nfor each limit a:\n  pref[0] = old[0]\n  for j = 1..K: pref[j] = pref[j-1] + old[j]\n  for j = 0..K:\n    new[j] = pref[j]\n    if j-a-1 >= 0: new[j] -= pref[j-a-1]\n  old = new\nanswer = old[K]")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/knapsack.html")[#text("CP-Algorithms：背包")]。



]
