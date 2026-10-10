#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("二维 0／1 关系压成 bitset")] <trick-bit-21>
*问题概述*　#text("给定 ")$n$#text(" 点简单无向图，多次询问不同节点 ")$u$#text("、")$v$#text(" 的公共邻居数，公共邻居必须同时与两点有边。另一独立模型为有向图的可达性闭包，求所有点对是否存在路径；本条强调用位集合批量处理布尔关系，两个模型不能混淆。")

*必要思路*　#text("每点邻居压成位集，共同邻居数是 ")$(op("adj")_(u) op("&") op("adj")_(v)).op("count")()$#text("。传递闭包可按 ")$k$#text(" 阶段，对能达 ")$k$#text(" 的行 ")$op("or") op("reach")_(k)$#text("。仍有 ")$O(n^2)$#text(" 或 ")$O(n^3/op("word"))$#text(" 量级，需估算矩阵内存；不是有位集就变线性。")

*参考*　#link("https://oi-wiki.org/math/bit/")[#text("OI Wiki：位操作")]。


参见 #link(<book-bitset-knapsack>)[bitset 背包与方案恢复]。


]
