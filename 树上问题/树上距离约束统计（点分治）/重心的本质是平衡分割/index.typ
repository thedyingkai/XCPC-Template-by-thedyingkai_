#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("重心的本质是平衡分割")] <trick-tree-19>
*问题概述*　#text("给定 ")$n$#text(" 点无向树，选择节点 ")$u$#text(" 并删除 ")$u$#text(" 及其 关联边，令 M(u) 为剩余最大连通块的节点数，空图取 0。求使 M(u) 最小的节点，或任意满足 ")$M(u)≤n/2$#text(" 的重心，用作平衡分治中心。")

*必要思路*　#text("每个候选 ")$u$#text(" 检查 max(n-sz[u],各儿子 sz)，取最小者；重心删后每块")$≤n/2$#text("。节点等权且边长为正时，重心还最小化到所有节点的距离和；有非负节点权时改用子树权重判断加权中位点。负边长不能沿用这一距离结论。")

*参考*　#link("https://oi-wiki.org/graph/tree-centroid/")[#text("OI Wiki：树的重心")]。



]
