#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("区间跳过子树：把依赖背包变序列 DP")] <trick-dp-36>
*问题概述*　#text("给定有根树，每点 ")$u$#text(" 有非负整数费用 ")$w_u$#text(" 和价值 ")$v_u$#text("。选择一个点集，若选 ")$u$#text(" 则其全部祖先也必须选；允许空集，总费用不得超过 ")$K$#text("。求总价值最大值，目标复杂度为 ")$O(n K)$#text("，不要求容量恰好用满。")

*必要思路*　#text("先做 DFS 前序。处理到 ")$u$#text(" 时，要么付费用选 ")$u$#text(" 并进入下一个位置，要么不选 ")$u$#text("、直接跳到整棵子树后面。子树是连续区间，因而可用位置与预算做 ")$O(n K)$#text(" 转移。仅适用于“不选祖先就必须整棵跳过”的依赖方向。自行推导。")

*实现提示*　#text("前序节点为 ")$op("node")_(0 dots.h n-1)$#text("，")$op("out")_(u)$#text(" 是子树后的首个位置。")$op("dp")_(i,b)$#text(" 表示将要处理位置 ")$i$#text("、已花 ")$b$#text(" 的最大价值。零费用也可用，位置始终增加；")$O(n K)$#text(" 时间与空间。")

*伪代码*（需结合题目接口实现）

#trick-code("dp[0][0] = 0; other states = -INF\nfor i = 0..n-1:\n  u = node[i]\n  for b = 0..K:\n    if dp[i][b] unreachable: continue\n    // skip u and all descendants\n    dp[out[u]][b] = max(dp[out[u]][b], dp[i][b])\n    // choose u, next node may be a child or another subtree\n    if b + weight[u] <= K:\n      dp[i+1][b+weight[u]] = max(\n        dp[i+1][b+weight[u]], dp[i][b] + value[u])\nanswer = max(dp[n][0..K])")

*参考*　#link("https://oi-wiki.org/dp/tree/")[#text("OI Wiki：树形 DP")]。



]
