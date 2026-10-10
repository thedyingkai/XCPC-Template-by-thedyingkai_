#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("分治优化：先证明决策单调")] <trick-dp-28>
*问题概述*　#text("给定长度 ")$n$#text(" 的序列、可查询的区间代价 cost(l,r) 和整数 ")$1≤K≤n$#text("。将序列恰分成 ")$K$#text(" 个非空连续段，最小化代价之和。已证明固定层 ")$t$#text(" 的最优切点 ")$op("opt")_t(i)$#text(" 随 ")$i$#text(" 非降，要求利用这一性质加速分段 DP。")

*必要思路*　#text("若同一层最优切点 ")$op("opt")_(i)$#text(" 随 ")$i$#text(" 单调，用分治计算中点，并把左右区间候选范围限制在 ")$op("opt")_(op("mid"))$#text(" 两侧，常达每层 ")$O(n log n)$#text("。前一层必须已算完，区间代价查询也要计入复杂度。")

*实现提示*　#text("恰分 ")$t$#text(" 个非空段。调用 ")$op("compute")(t,n,t-1,n-1)$#text("，prev 是完整上一层；最小下标打破平局。只有证明 opt 单调后才能用，每层 ")$O(n log n)$#text(" 次代价查询。")

*伪代码*（需结合题目接口实现）

#trick-code("compute(L, R, optL, optR):\n  if L > R: return\n  mid = floor((L+R)/2)\n  bestValue = INF; bestJ = -1\n  for j = optL..min(optR, mid-1):\n    if prev[j] is unreachable: continue\n    value = prev[j] + cost(j+1, mid)\n    if bestJ == -1 or value < bestValue:\n      bestValue = value; bestJ = j\n  cur[mid] = bestValue\n  assert bestJ != -1  // valid layer must have a cut\n  compute(L, mid-1, optL, bestJ)\n  compute(mid+1, R, bestJ, optR)")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/divide-and-conquer-dp.html")[#text("CP-Algorithms：分治优化 DP")]。



]
