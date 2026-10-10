#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("有限状态转移用矩阵加速")] <trick-dp-33>
*问题概述*　#text("给定 ")$m$#text(" 个有限状态、固定转移计数矩阵 ")$T$#text("、初始状态计数向量 ")$v_0$#text(" 和长度 ")$L$#text("，可达 ")$10^18$#text("。每一步都使用同一个 ")$T$#text("，求 ")$L$#text(" 步后落在指定终止状态集合的路径数，按模数取模；状态转移不随位置变化。")

*必要思路*　#text("采用列向量约定，")$T$#text(" 的第 (to,from) 项是从 from 到 to 的一步转移数，")$v_L=T^L v_0$#text("。用快速幂在 ")$O(m^3 log L)$#text(" 时间计算矩阵幂，再汇总目标状态。最短定长路径可改为 min-plus 半环，但初始值及乘法都要相应改。位置相关转移只有周期等结构存在时才能合成后幂。")

*参考*　#link("https://cp-algorithms.com/algebra/binary-exp.html")[#text("CP-Algorithms：快速幂")]。


参见 #link(<book-matrix-power>)[矩阵运算与快速幂]。

参见 #link(<chapter-recurrence>)[线性递推与第 n 项查询]。


]
