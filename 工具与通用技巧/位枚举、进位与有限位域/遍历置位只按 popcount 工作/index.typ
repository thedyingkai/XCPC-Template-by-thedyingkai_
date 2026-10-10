#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("遍历置位只按 popcount 工作")] <trick-bit-07>
*问题概述*　#text("给定 ")$W$#text(" 位无符号掩码 ")$S$#text("，每个置位对应一个有效下标。要求恰好访问这些置位各一次，返回其位号或单个位掩码；")$S=0$#text(" 时不访问任何元素，工作量与 popcount(S) 成正比。")

*必要思路*　#text("反复 ")$x op("&=") x-1$#text(" 去掉最低置位；当前位可用 ctz(x) 取得。无符号 ")$x$#text(" 的 ")$op("lowbit")=x op("&") (-x)$#text("，用于枚举每个有效元素。")$x=0$#text(" 时停止，避免调用零的 ctz；用 64 位输入就配套 ctzll。")

*参考*　#link("https://cp-algorithms.com/algebra/bit-manipulation.html")[#text("CP-Algorithms：位操作")]。



]
