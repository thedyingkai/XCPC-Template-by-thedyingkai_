#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("反 Nim：全是 1 的末局单独处理")] <trick-game-03>
*问题概述*　#text("初始有至少一颗石子，分在 ")$n$#text(" 堆中。每步选择一堆取走任意正数颗，取走全局最后一颗石子的人立即输。双方最优行动，判断先手是否必胜；初始空局面不纳入这个标准规则。")

*必要思路*　#text("若所有非空堆都为 1，非空堆数为偶数时先手胜；若至少一堆大于 1，胜负按普通异或和非零判断。走法进入“全为 1”区域时需留下奇数个 1。空局面的终止规则单独明确，不能把所有普通 ")$op("SG")=0$#text(" 的结论直接反转。")

*参考*　#link("https://cp-algorithms.com/game_theory/sprague-grundy-nim.html")[#text("CP-Algorithms：SG 与 Nim")]。


参见 #link(<book-sg>)[Nim 与反 Nim 的判定接口]。


]
