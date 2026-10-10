#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("边差分：LCA 要减两次")] <trick-tree-06>
*问题概述*　#text("给定树及 ")$q$#text(" 条端点指定的简单路径，求每条原树边被这些路径经过的次数。点对路径无方向，重复路径重复计数；当两个端点相同，本次对所有边的贡献均为 0。")

*必要思路*　#text("做 ")$d_(u)++,d_(v)++,d_(op("LCA")(u,v))-=2$#text("，再向上汇总；非根点 ")$v$#text(" 的汇总量即边 ")$op("parent")_(v)-v$#text(" 被走的次数。点差分和边差分不能混用，")$u=v$#text(" 时所有边贡献应为 0。")

*参考*　#link("https://oi-wiki.org/graph/tree-basic/")[#text("OI Wiki：树基础")]。



]
