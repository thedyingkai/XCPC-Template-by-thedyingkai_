#import "延伸：固定根树的 DFS 首次访问序数量/index.typ" as section-0
#import "延伸：只给 DFS 前序，能有多少棵树/index.typ" as section-1
#import "延伸：若儿子必须按标签递增访问/index.typ" as section-2
#import "延伸：给前序与深度，树是否唯一/index.typ" as section-3
#import "延伸：前序加后序与二叉树的单儿子歧义/index.typ" as section-4
#import "延伸：一般图的 DFS 数量不能直接乘出度阶乘/index.typ" as section-5

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("子树拍平成连续区间")] <trick-tree-01>
*问题概述*　#text("给定固定根 ")$r$#text(" 的树，每点有数值 ")$a_u$#text("，执行对子树全部节点加 ")$d$#text("、查询子树数值和等操作。子树指在同一固定根下包含 ")$u$#text(" 及其全部后代的点集；要求把操作映射为序列中的一个连续区间，且每点只对应一个数组位置。")

*必要思路*　#text("只在首次进入节点时编号，子树对应 ")$[op("tin")_(u),op("tout")_(u)]$#text("，转成序列区间。不要把首次编号与用于 LCA 的“反复记录父节点”的欧拉序混用。边权放在较深端点时，子树内部边应排除 ")$u$#text(" 自己。")

*参考*　#link("https://oi-wiki.org/graph/tree-basic/")[#text("OI Wiki：树基础")]。


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

#section-4.render(code)

#section-5.render(code)

]
