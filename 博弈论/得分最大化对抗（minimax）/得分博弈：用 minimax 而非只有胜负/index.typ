#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("得分博弈：用 minimax 而非只有胜负")] <trick-game-16>
*问题概述*　#text("给定整数序列 ")$a_1…a_n$#text("，两人轮流从当前序列左端或右端取走一个数并计入自己的得分，直到序列为空。双方最大化自己的最终得分减对方得分，求先手可保证的最大分差；整数可为负。")

*必要思路*　#text("零和且总收益定义清楚时，记当前行动者的最优净收益，转移是 max(本步收益-下一状态值)。若双方目标不构成零和，需明确效用与平局偏好；单个 SG 值不能表达分数。")

*参考*　#link("https://www.luogu.com.cn/article/bk8r8qm6")[#text("洛谷 zhaojiaen：博弈论")]。



]
