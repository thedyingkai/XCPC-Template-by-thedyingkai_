#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("线性基判可达与计数")] <trick-bit-17>
*问题概述*　#text("给定 ")$n$#text(" 个有编号的 ")$W$#text(" 位非负整数及目标 ")$X$#text("，求是否存在下标子集 ")$S$#text(" 使 ")$op("xor")_(i∈S)a_i=X$#text("，并求这样的子集个数。包含空集，不限制子集大小；重复数值不同下标分别计为不同选择。")

*必要思路*　#text("将 ")$X$#text(" 用同一高位基消去，最终为 0 则可达。基秩为 ")$r$#text("，每个可达 ")$X$#text(" 都有 ")$2^(n-r)$#text(" 个子集映射到它，来自线性映射核维数。空集包含在内；若限制子集大小，单个普通基不够。")

*参考*　#link("https://oi-wiki.org/math/linear-algebra/basis/")[#text("OI Wiki：线性基")]。



]
