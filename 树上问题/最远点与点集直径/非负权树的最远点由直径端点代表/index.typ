#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("非负权树的最远点由直径端点代表")] <trick-tree-09>
*问题概述*　#text("给定 ")$n$#text(" 点无向树，所有边权非负。对每个节点 ")$u$#text("，求 ")$max_v op("dist")(u,v)$#text("，其中 dist 是唯一简单路径长度，")$v$#text(" 可以等于 ")$u$#text("；要求在线性次遍历内得到全部节点的最远距离。")

*必要思路*　#text("取一条直径端点 ")$A$#text("、")$B$#text("，")$op("ecc")(u)=max(op("dist")(u,A),op("dist")(u,B))$#text("，做几次遍历即可。非负边权保证距离的树度量性质；负边权时这条代表性和两次最远搜索都可能失效，应改用树形 DP。")

*参考*　#link("https://oi-wiki.org/graph/tree-diameter/")[#text("OI Wiki：树的直径")]。



]
