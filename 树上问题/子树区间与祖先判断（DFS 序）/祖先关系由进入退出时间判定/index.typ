#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("祖先关系由进入退出时间判定")] <trick-tree-02>
*问题概述*　#text("给定以 ")$r$#text(" 为固定根的树和多组节点对 (u,v)，判断 ")$u$#text(" 是否为 ")$v$#text(" 的祖先。本条把节点自身也视为自己的祖先，根在全部询问中不变；预处理后希望每次判断为 ")$O(1)$#text("。")

*必要思路*　#text("")$u$#text(" 是 ")$v$#text(" 的祖先当且仅当 ")$op("tin")_(u)≤op("tin")_(v)≤op("tout")_(u)$#text("。配合子树区间可把“属于某祖先分支”变区间包含；这是固定根下的性质，换根后需分类，不能继续直接比较原区间。")

*参考*　#link("https://cp-algorithms.com/graph/lca_binary_lifting.html")[#text("CP-Algorithms：倍增 LCA")]。



]
