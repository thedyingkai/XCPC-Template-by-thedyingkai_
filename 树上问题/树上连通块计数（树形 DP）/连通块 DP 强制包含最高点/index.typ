#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("连通块 DP 强制包含最高点")] <trick-tree-15>
*问题概述*　#text("给定无向树，统计所有非空节点子集 ")$S$#text("，使 ")$S$#text(" 所诱导的子图连通。按原节点编号区分子集，不能因选取根不同把同一 ")$S$#text(" 重复计数；可按指定模数输出方案数。")

*必要思路*　#text("令 ")$f_(u)$#text(" 只数子树内且包含 ")$u$#text(" 的连通集，每个儿子选不连接或连接一个包含该儿子的集。每个非空连通集有唯一深度最小点，把 ")$f_(u)$#text(" 求和便不重不漏；不能把已不连着儿子根的集合拿来连接。")

*参考*　#link("https://oi-wiki.org/dp/tree/")[#text("OI Wiki：树形 DP")]。



]
