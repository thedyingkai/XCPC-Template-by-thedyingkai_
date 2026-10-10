#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("删一个点：答案是各分支的交叉贡献")] <trick-tree-20>
*问题概述*　#text("给定 ")$n$#text(" 点无向树，对每个节点 ")$u$#text("，求在删除 ")$u$#text(" 后仍保留的不同节点无序对 {a,b} 中，")$a$#text("、")$b$#text(" 不再连通的数量。另一个变形统计所有经过 ")$u$#text(" 的不同端点路径，此时端点允许为 ")$u$#text("；两个目标的计数域不同。")

*必要思路*　#text("剩余分支大小为 ")$s_i$#text("，先算 ")$sum _(i<j)s_i s_j=((n-1)^2- sum  s_i^2)/2$#text("；若路径允许端点为 ")$u$#text("，再加 ")$n-1$#text("。可逐分支用累计数乘当前大小避免平方溢出。这是唯一树路径经过 ")$u$#text(" 的自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
