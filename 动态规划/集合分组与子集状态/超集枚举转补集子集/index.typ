#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("超集枚举转补集子集")] <trick-bit-10>
*问题概述*　#text("给定有限全集位掩码 ")$U$#text(" 和 ")$S⊆U$#text("，枚举所有满足 ")$S⊆T⊆U$#text(" 的掩码 ")$T$#text("，每个一次。只有 ")$U$#text(" 中的位可以出现，不能把机器字范围外的取反位算作自由元素。")

*必要思路*　#text("剩余自由位为 U xor S，枚举其子掩码 ")$T$#text("，输出 S or T。")$U$#text(" 必须是题目有限位域，不能直接把机器字 ~S 当全集。共有 ")$2^(op("popcount")(U op("xor") S))$#text(" 个超集；仅当全集含全部 ")$W$#text(" 个有效位时，才能写成 ")$2^(W-op("popcount")(S))$#text("。")$S$#text(" 不是 ")$U$#text(" 子集时先判非法。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/all-submasks.html")[#text("CP-Algorithms：子掩码枚举")]。



]
