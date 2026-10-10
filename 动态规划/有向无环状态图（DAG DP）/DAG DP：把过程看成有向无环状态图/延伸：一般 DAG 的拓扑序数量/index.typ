#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 5, outlined: true, numbering: none)[#text("延伸：一般 DAG 的拓扑序数量")]

*延伸问题*　#text("给定 ")$n$#text(" 个有编号节点的 DAG，统计全部节点排列 π，使每条边 u→v 都满足 ")$u$#text(" 在 ")$v$#text(" 之前。只按节点排列计数，重复边不产生不同方案；本方法要求 ")$n$#text(" 小到可以开 ")$2^n$#text(" 数组，例如 ")$n≤22$#text("。")

*必要思路*　#text("令 ")$op("pre")_(v)$#text(" 为 ")$v$#text(" 的直接前驱掩码，")$op("dp")_(S)$#text(" 为已经输出节点集合恰为 ")$S$#text(" 的合法前缀数。只有 ")$v$#text("∉")$S$#text(" 且 ")$op("pre")_(v)⊆S$#text(" 才能把 ")$v$#text(" 加到末尾；每个完整排列有唯一前缀链，因此不重不漏。复杂度 ")$O(n 2^n)$#text("，空间 ")$O(2^n)$#text("，一般 DAG 不能仅靠节点数套阶乘或树公式。")

#trick-code("dp[0] = 1; dp[other masks] = 0\nfor S = 0..(1<<n)-1:\n  for v = 0..n-1:\n    if ((S>>v)&1) == 0 and (pre[v]&S) == pre[v]:\n      dp[S|(1<<v)] += dp[S]\nanswer = dp[(1<<n)-1]")

*参考*　#link("https://oi-wiki.org/dp/state/")[#text("OI Wiki：状压 DP")]。


]
