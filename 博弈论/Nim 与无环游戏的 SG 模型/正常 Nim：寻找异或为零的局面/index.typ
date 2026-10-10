#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("正常 Nim：寻找异或为零的局面")] <trick-game-02>
*问题概述*　#text("有 ")$n$#text(" 堆石子，第 ")$i$#text(" 堆大小为非负整数 ")$a_i$#text("。每回合选择一堆，从中取走任意正数颗，但不得超过该堆现有数量；不能加石子或同时改变其他堆。轮到某人时所有堆都为空则该人输，求先手是否必胜及一手获胜操作。")

*必要思路*　#text("异或和 ")$X=0$#text(" 必败，否则必胜。构造时找 ")$a_(i)$#text(" 满足 ")$(a_(i) op("xor") X)<a_(i)$#text("，把这堆降至 ")$a_(i) op("xor") X$#text("。每步只改一堆、允许任意正数、不能增堆，缺任一条件都需重新分析。")

*参考*　#link("https://cp-algorithms.com/game_theory/sprague-grundy-nim.html")[#text("CP-Algorithms：SG 与 Nim")]。



]
