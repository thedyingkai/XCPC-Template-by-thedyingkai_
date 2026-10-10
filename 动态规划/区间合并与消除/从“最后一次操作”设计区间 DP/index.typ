#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("从“最后一次操作”设计区间 DP")] <trick-dp-14>
*问题概述*　#text("给定线性排列的 ")$n$#text(" 堆石子，初始第 ")$i$#text(" 堆重量 ")$a_i≥0$#text("。每次只能合并两堆相邻的石子，新堆重量为两者之和，本次费用也等于该和。必须合并成一堆，求所有合并费用之和的最小值。")

*必要思路*　#text("最后一次必把 [l,k] 与 ")$[k+1,r]$#text(" 合并，")$op("dp")_(l,r)=min_k(op("dp")_(l,k)+op("dp")_(k+1,r))+sum(l,r)$#text("。按区间长度递增计算，朴素 ")$O(n^3)$#text("。先固定最后操作，常比枚举第一步清楚。")

*参考*　#link("https://oi-wiki.org/dp/interval/")[#text("OI Wiki：区间 DP")]。



]
