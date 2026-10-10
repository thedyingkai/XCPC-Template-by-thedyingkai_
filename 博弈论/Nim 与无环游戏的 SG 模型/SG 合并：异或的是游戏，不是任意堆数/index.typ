#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("SG 合并：异或的是游戏，不是任意堆数")] <trick-game-06>
*问题概述*　#text("给定若干独立、有限、正常终止的公平子游戏及各自初始状态。每回合恰选择一个子游戏执行一次合法操作，其余子游戏完全不变；当全部子游戏都无法行动时，轮到的一方输。已能求单游戏 SG，求合成游戏胜负。")

*必要思路*　#text("先求单游戏 ")$op("sg")(x)=op("mex")(op("sg")(y))$#text("，再异或各 sg。双方必须使用同一行动规则，游戏有限且正常终止；共享预算、一步同时改多个游戏或反常终止时，普通异或合并未必成立。")

*参考*　#link("https://www.luogu.com.cn/article/hs0vf931")[#text("洛谷 MPLN：公平组合游戏")]。



]
