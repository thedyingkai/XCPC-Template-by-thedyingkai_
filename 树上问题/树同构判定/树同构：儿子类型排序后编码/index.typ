#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("树同构：儿子类型排序后编码")] <trick-tree-24>
*问题概述*　#text("给定两棵无向、无节点标签、无边权的树，判断是否存在保持邻接关系的节点双射。节点编号与邻接表儿子顺序不构成标签；若有指定根，双射还须对应两棵树的根。本条要求精确判断而非依赖可能碰撞的单个随机哈希。")

*必要思路*　#text("有根树把儿子类型 ID 排序，将整个列表映射成新 ID；精确字典可避免随机哈希碰撞。无根树先找中心（不断剥叶，最后一个或两个点），比较其根化形式；中心与重心不是同一概念。")

*参考*　#link("https://oi-wiki.org/graph/tree-hash/")[#text("OI Wiki：树哈希")]。



]
