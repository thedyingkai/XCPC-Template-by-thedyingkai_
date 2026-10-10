#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("路径顺序敏感：左右两端分别收集")] <trick-tree-22>
*问题概述*　#text("给定树，每点存一个字符串或矩阵，op 为字符串拼接或矩阵乘法等结合但不交换的运算。对有方向的询问 (u,v)，求唯一简单路径按 ")$u$#text(" 到 ")$v$#text(" 的节点顺序做 op 的结果，端点及 LCA 各出现一次。")

*必要思路*　#text("从 ")$u$#text("、")$v$#text(" 两侧分别收集链段，维护每段正向和反向聚合；拼接时 ")$u$#text(" 侧向上、")$v$#text(" 侧向下，最后接 LCA 附近段。结合律足够做区间结构，但非交换运算不能随意交换链段。")

*参考*　#link("https://oi-wiki.org/graph/hld/")[#text("OI Wiki：树链剖分")]。



]
