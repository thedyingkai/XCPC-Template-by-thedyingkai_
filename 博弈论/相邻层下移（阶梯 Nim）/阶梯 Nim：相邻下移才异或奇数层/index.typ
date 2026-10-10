#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("阶梯 Nim：相邻下移才异或奇数层")] <trick-game-10>
*问题概述*　#text("编号 1…n 的阶梯上有非负整数 ")$a_i$#text(" 颗石子。每步选择一层 ")$i≥1$#text("，将其中任意正数颗石子恰下移一级到 ")$i-1$#text("；第 0 层石子不能再操作。无法移动者输，判断先手胜负；不允许一次跳过多级。")

*必要思路*　#text("只异或奇数层的数量。操作偶数层时，可把刚进入奇数层的石子继续下移来还原有效局面；操作奇数层相当于减少有效 Nim 堆。若允许任意跳多层，规则已改变，不可沿用此结论。")

*参考*　#link("https://oi-wiki.org/math/game-theory/impartial-game/")[#text("OI Wiki：公平组合游戏")]。



]
