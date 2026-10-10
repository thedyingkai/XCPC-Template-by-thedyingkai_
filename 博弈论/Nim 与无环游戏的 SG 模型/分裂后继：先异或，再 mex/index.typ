#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("分裂后继：先异或，再 mex")] <trick-game-07>
*问题概述*　#text("初始为长度 ")$n$#text(" 的连续棋子段。每步在某一现存段内删除相邻的两枚棋子，删除后左右剩余棋子分别成为独立段，不能跨空缺操作；所有段长度都小于 2 时无合法操作，无法行动者输。求单段长度 ")$n$#text(" 的 SG。")

*必要思路*　#text("设 ")$g_n$#text(" 为长度 ")$n$#text(" 的段的 SG。")$g_0=g_1=0$#text("；删除相邻两枚后，左段长 ")$l$#text("、右段长 ")$n-2-l$#text("，二者独立，后继 SG 为 ")$g_l op("xor") g_(n-2-l)$#text("。因此 ")$g_n=op("mex") lr({g_l op("xor") g_(n-2-l) mid 0<=l<=n-2})$#text("。先异或子游戏，再对所有合法删除位置求 mex。")

*参考*　#link("https://www.luogu.com.cn/article/hs0vf931")[#text("洛谷 MPLN：公平组合游戏")]。



]
