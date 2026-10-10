#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("启发式合并：小集合搬进大集合")] <trick-tree-17>
*问题概述*　#text("给定固定根树，每个节点有颜色 ")$c_u$#text("。对每个 ")$u$#text(" 求其子树内各颜色的出现频次，或由频次得到不同颜色数等统计量。要求复用子树容器，避免把同一子树信息沿祖先链反复完整复制；颜色相同的键需要累计而非视为不同键。")

*必要思路*　#text("按当前集合大小从小向大合并。若每个对象搬迁后所在容器规模至少翻倍，每个对象只搬 ")$O(log n)$#text(" 次；容器每次插入的成本另算。键去重场景要单独核查搬迁分析，不可把所有合并都当作线性。")

*参考*　#link("https://oi-wiki.org/graph/dsu-on-tree/")[#text("OI Wiki：树上启发式合并")]。



]
