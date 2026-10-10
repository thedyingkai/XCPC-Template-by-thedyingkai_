#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("威佐夫：两堆可同量同时减少")] <trick-game-12>
*问题概述*　#text("两堆石子大小为非负整数 ")$a$#text("、")$b$#text("。每步可以从一堆取任意正数颗，或者从两堆各取相同的正数颗，均不能超过存量；两堆都空时无法操作者输。判断先手胜负，不能套只允许动一堆的 Nim 规则。")

*必要思路*　#text("令 ")$a≤b$#text("，")$k=b-a$#text("；")$P$#text(" 局面恰为 ")$a=floor(k φ)$#text("、")$b=a+k$#text("，")$φ=(1+sqrt(5))/2$#text("。不是普通 Nim。大整数判定要考虑黄金比例计算精度，用整数比较或高精度确认临界值。")

*参考*　#link("https://www.luogu.com.cn/article/bk8r8qm6")[#text("洛谷 zhaojiaen：博弈论")]。



]
