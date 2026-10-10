#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("有限位域的取反与移位边界")] <trick-bit-25>
*问题概述*　#text("给定有效位数 ")$1≤w≤W$#text(" 和只含低 ")$w$#text(" 位的无符号掩码 ")$S$#text("，构造同一有限全集中的补集及全 1 掩码。还需要在 ")$S≠0$#text(" 时求最低置位号；要求 ")$w=W$#text(" 和 ")$S=0$#text(" 时也不触发非法移位或未定义的零输入操作。")

*必要思路*　#text("使用 unsigned 类型，")$W$#text(" 位全集是明确的 ")$U$#text("，再做 U xor S。1ULL<<b 仅当 b<64；64 位全 1 用 ~0ULL，不能 ")$(1op("ULL") op("<<") 64)-1$#text("。GCC 的 ctz/clz 对 0 未定义，")$C++20$#text(" 的 countr_zero 等另有定义，不能混淆。")

*参考*　#link("https://cp-algorithms.com/algebra/bit-manipulation.html")[#text("CP-Algorithms：位操作")]。



]
