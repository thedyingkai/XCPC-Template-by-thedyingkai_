#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("树上异或路径不用 LCA")] <trick-tree-03>
*问题概述*　#text("给定无向树，每条边有 ")$W$#text(" 位非负整数权值。对多组 (u,v)，求唯一简单路径上全部边权的按位 XOR；")$u=v$#text(" 时空路径值为 0。扩展目标可为全部点对路径 XOR 的最大值，但本条权值在边上而非点上。")

*必要思路*　#text("令 ")$op("xr")_(u)$#text(" 为根到 ")$u$#text(" 的边权异或，则路径值为 ")$op("xr")_(u) op("xor") op("xr")_(v)$#text("，公共前缀自动抵消。点权路径会把 LCA 的点权抵消掉，需要额外补上该点；不能将加法距离也省掉 LCA。")

*参考*　#link("https://oi-wiki.org/math/bit/")[#text("OI Wiki：位操作")]。



]
