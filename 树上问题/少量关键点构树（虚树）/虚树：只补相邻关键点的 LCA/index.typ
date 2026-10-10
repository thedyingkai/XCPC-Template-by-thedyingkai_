#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("虚树：只补相邻关键点的 LCA")] <trick-tree-13>
*问题概述*　#text("给定已预处理 LCA 的固定根树，多次询问指定 ")$k$#text(" 个关键点。要求构造一棵节点数为 ")$O(k)$#text(" 的压缩树，保留关键点及所需分叉祖先，父子边对应原树的一条祖先链；后续 DP 只依赖这些链可聚合的信息，中间点的独立贡献必须先归并。")

*必要思路*　#text("按 DFS 序排序，加入相邻点 LCA，再排序去重并按祖先关系连边，虚树规模 ")$O(k)$#text("。虚边存原链需要的信息：长度、最小边权等；中间普通点若有独立贡献，必须先聚合，不能直接删除。仅清理本次用到的点。")

*实现提示*　#text("tin、tout、depth、LCA 需先在原树准备；ancestor(a,b) 检查 DFS 区间包含。加入相邻 LCA 后重新排序去重，栈中只保留祖先链。")$k=0$#text(" 单独返回；构树 ")$O(k log k)$#text(" 加 ")$O(k)$#text(" 次 LCA。")

*伪代码*（需结合题目接口实现）

#trick-code("nodes = unique keys sorted by tin\nfor i = 1..size(nodes)-1 using the original list:\n  extra.push(LCA(nodes[i-1], nodes[i]))\nnodes = unique(nodes + extra), sorted by tin\nstack = empty\nfor u in nodes:\n  while stack not empty and not ancestor(stack.top(), u):\n    stack.pop()\n  if stack not empty:\n    p = stack.top()\n    add virtual edge p -> u\n    edge_length = distRoot[u] - distRoot[p]\n  stack.push(u)\nvirtual_root = nodes[0]")

*参考*　#link("https://oi-wiki.org/graph/virtual-tree/")[#text("OI Wiki：虚树")]。



]
