#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("巴什：按一回合配对")] <trick-game-04>
*问题概述*　#text("一堆有 ")$n≥0$#text(" 颗石子，给定整数 ")$m≥1$#text("。每次必须取走 1…m 颗且不能超过剩余数量；无石子可取者输。求先手是否必胜，并在必胜时构造合法首步。")

*必要思路*　#text("")$P$#text(" 局面是 ")$n$#text(" 为 ")$m+1$#text(" 的倍数。先手先调到倍数，此后对方取 ")$x$#text("，就取 ")$m+1-x$#text("。取数集合不连续时不能照套，需做胜负或 SG 递推。")

*参考*　#link("https://www.luogu.com.cn/article/bk8r8qm6")[#text("洛谷 zhaojiaen：博弈论")]。



]
