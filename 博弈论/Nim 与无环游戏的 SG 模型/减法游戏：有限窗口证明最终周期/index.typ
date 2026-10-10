#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("减法游戏：有限窗口证明最终周期")] <trick-game-05>
*问题概述*　#text("给定非空有限正整数集合 ")$S$#text(" 和一堆 ")$n$#text(" 颗石子。每次只能取 ")$s∈S$#text(" 颗且 ")$s$#text(" 不超过剩余数，无法取者输。")$n$#text(" 很大，要求根据已计算的有限 SG 序列寻找并证明最终周期，以回答远处状态；不预设周期长度很小。")

*必要思路*　#text("设 ")$max(S)=M$#text("，SG 或胜负只依赖前 ")$M$#text(" 项。完整长度 ")$M$#text(" 的状态窗口若重复，未来将重复，可据此证明最终周期；必须比较完整窗口而非几个点。")$op("SG")≤$#text("可选后继数，但窗口空间可能很大，不能保证短周期。")

*参考*　#link("https://cp-algorithms.com/game_theory/sprague-grundy-nim.html")[#text("CP-Algorithms：SG 与 Nim")]。



]
