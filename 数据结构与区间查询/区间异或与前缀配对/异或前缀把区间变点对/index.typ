#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("异或前缀把区间变点对")] <trick-bit-01>
*问题概述*　#text("给定长度 ")$n$#text(" 的 ")$W$#text(" 位非负整数数组和目标 ")$K$#text("，求非空连续子数组 [l,r] 的数量，使 ")$a_l op("xor") … op("xor") a_r=K$#text("。按不同端点对区分子数组，允许元素重复及 ")$K=0$#text("，不计空区间。")

*必要思路*　#text("令 ")$p_(0)=0$#text("，")$p_(i)=a_(1) op("xor")…op("xor") a_(i)$#text("，条件为 ")$p_(l-1)=p_(r) op("xor") K$#text("。扫描 ")$r$#text("，先查询此前前缀次数，再插入 ")$p_(r)$#text("。初始插入 ")$p_(0)$#text("；")$K=0$#text(" 时若先插入会多计空区间。此为异或消去的自行推导。")

*参考*　#link("https://oi-wiki.org/math/bit/")[#text("OI Wiki：位操作")]。



]
