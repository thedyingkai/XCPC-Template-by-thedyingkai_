#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("Silver Dollar：把棋子变成间隙")] <trick-game-11>
*问题概述*　#text("整数位置 0,1,2,… 上放有 ")$n$#text(" 枚棋子，位置 ")$x_1<…<x_n$#text("。每步选择一枚，向左移动到任意更小的非负空位置，移动中不得跨越其他棋子；不移除棋子。无法移动者输，判断初始局面的先手胜负。")

*必要思路*　#text("设排序后位置为 ")$x_(1 dots.h n)$#text("，")$g_(1)=x_(1)$#text("（最左可到 0），")$g_(i)=x_(i)-x_(i-1)-1$#text("。从最右间隙开始隔一个取一个，即 ")$g_(n),g_(n-2),…$#text(" 做 Nim 异或。一次移动在相邻间隙间转移空位，可按阶梯博弈理解。棋子移除或允许跨越会改变模型。")

*参考*　#link("https://www.codechef.com/wiki/tutorial-coin-game")[#text("CodeChef 官方题解：A Coin Game（Silver Dollar）")]。



]
