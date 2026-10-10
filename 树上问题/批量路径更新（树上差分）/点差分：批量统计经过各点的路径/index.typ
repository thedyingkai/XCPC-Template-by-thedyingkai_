#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("点差分：批量统计经过各点的路径")] <trick-tree-05>
*问题概述*　#text("给定树及 ")$q$#text(" 条由端点 ")$(u_i,v_i)$#text(" 指定的简单路径。求每个节点出现在多少条路径中，路径两个端点都计入；")$u_i=v_i$#text(" 的路径只包含该节点，重复询问按出现次数计数。")

*必要思路*　#text("")$c=op("LCA")(u,v)$#text("，做 ")$d_(u)++,d_(v)++,d_(c)--,d_(op("parent")(c))--$#text("；根的父亲不存在则跳过。最后子树向父亲累加，得到点覆盖数。端点与 LCA 各保留一次，用一条长度 0 的路径检查边界。")

*参考*　#link("https://oi-wiki.org/graph/tree-basic/")[#text("OI Wiki：树基础")]。



]
