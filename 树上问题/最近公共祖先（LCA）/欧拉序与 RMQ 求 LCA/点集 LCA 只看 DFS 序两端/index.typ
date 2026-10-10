#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("点集 LCA 只看 DFS 序两端")] <trick-tree-23>
*问题概述*　#text("给定以 ")$r$#text(" 为固定根、已支持两点 LCA 的树，以及非空节点集合 ")$S$#text("。求全部 ")$S$#text(" 的共同最低祖先，即同时为所有节点祖先且深度最大的节点；希望集合摘要只保留 DFS 首次进入序中最早和最晚的两个节点。")

*必要思路*　#text("设 ")$a$#text(" 为 ")$S$#text(" 中 tin 最小的节点，")$b$#text(" 为 tin 最大的节点，则 ")$op("LCA")(S)=op("LCA")(a,b)$#text("。祖先子树在首次进入 DFS 序中是连续区间：同时含两端，就包含所有集合节点。集合摘要只需维护这两个端点；不能改用节点编号的最小最大值。")

*依据*　自行推导/归纳，理由已写在思路中。



]
