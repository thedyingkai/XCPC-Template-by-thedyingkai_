#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("玩家规则不同：把行动者加入状态")] <trick-game-15>
*问题概述*　#text("给定有限局面集合、Alice 和 Bob 各自的合法转移关系及当前行动者。双方交替行动，无合法行动的一方输；同一局面的两人合法动作可以不同。求指定状态和行动者的胜负，有循环时按题目规定的无限对局规则处理。")

*必要思路*　#text("状态必须是 (局面,轮到谁)，分别列各自行动；有限图可倒推，允许循环则需按胜负平局处理。不要给原局面单独算普通 SG，因为相同状态不再对应同一组合法操作。")

*参考*　#link("https://cp-algorithms.com/game_theory/games_on_graphs.html")[#text("CP-Algorithms：有环图上的博弈")]。



]
