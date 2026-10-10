#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("枚举子掩码与 3^n 复杂度")] <trick-bit-08>
*问题概述*　#text("给定 ")$n$#text(" 位掩码 ")$S$#text("，枚举全部 ")$T⊆S$#text("，每个 ")$T$#text(" 只输出一次，包括 0 和 ")$S$#text("。另一任务对全部 ")$n$#text(" 位 ")$S$#text(" 枚举上述配对 (S,T)，要求说明总枚举数，而非误估为 ")$4^n$#text("。")

*必要思路*　#text("从 ")$op("sub")=S$#text(" 反复 ")$op("sub")=(op("sub")-1) op("&") S$#text("。若包含空集，在处理 ")$op("sub")=0$#text(" 后退出，不能继续下减。一个掩码有 ")$2^(op("popcount")(S))$#text(" 个子集；枚举所有 (S,sub) 总数为 ")$3^n$#text("，每位有不在 ")$S$#text("、仅在 ")$S$#text("、也在 sub 三种。")

*参考*　#link("https://cp-algorithms.com/algebra/all-submasks.html")[#text("CP-Algorithms：子掩码枚举")]。



]
