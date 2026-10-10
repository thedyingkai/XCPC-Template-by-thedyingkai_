#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("只操作未处理位置：并查集跳过")] <trick-misc-27>
*问题概述*　#text("长度 ")$n$#text(" 的序列初始全部未染色，依次执行操作 (l,r,c)：只把 [l,r] 中仍未染色的位置染为 ")$c$#text("，已染色位置永不改变。求全部操作后的颜色，允许区间重复；每个位置至多真正处理一次，不支持重新激活。")

*必要思路*　#text("维护 next(x) 为不小于 ")$x$#text(" 的首个未处理位置。处理 ")$x$#text(" 后让它跳到 ")$op("next")(x+1)$#text("，路径压缩后每点仅真正访问一次。要留 ")$n+1$#text(" 哨兵；若后续允许重新激活或改颜色，此结构不够。")

*参考*　#link("https://cp-algorithms.com/data_structures/disjoint_set_union.html")[#text("CP-Algorithms：并查集应用")]。



]
