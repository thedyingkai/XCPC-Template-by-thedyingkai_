#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("先手必胜不是“可走步数为奇数”")] <trick-game-01>
*问题概述*　#text("给定有限无环的局面转移图及初始局面 ")$s$#text("。双方轮流选择一条合法边转移，行动规则相同，没有合法转移的一方输；双方都采取最优策略。判断初始局面是先手必胜还是先手必败，不假定所有对局的步数相同。")

*必要思路*　#text("无操作为必败 ")$P$#text("；存在一步到 ")$P$#text(" 则是必胜 ")$N$#text("；所有后继均为 ")$N$#text(" 才是 ")$P$#text("。先写小规模搜索，再观察规律。只有每局操作数的奇偶已由局面唯一决定时，才能直接比奇偶。")

*参考*　#link("https://www.luogu.com.cn/article/hs0vf931")[#text("洛谷 MPLN：公平组合游戏")]。



]
