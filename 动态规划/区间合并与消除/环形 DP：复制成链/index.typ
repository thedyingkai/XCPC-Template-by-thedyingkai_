#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("环形 DP：复制成链")] <trick-dp-15>
*问题概述*　#text("给定环上依次排列的 ")$n$#text(" 堆石子，重量 ")$a_i≥0$#text("，首尾也相邻。每次合并两堆当前相邻的石子，费用为合并后重量，直至只剩一堆。求最小总费用；操作不改变环上的相对次序。")

*必要思路*　#text("复制数组成为长度 2n 的链，计算长度不超过 ")$n$#text(" 的区间，枚举 ")$[i,i+n-1]$#text("。这适用于解能在某个断点线性化的区间模型；要求绕环多次或有全局首尾约束时，复制不是完整解法。")

*参考*　#link("https://oi-wiki.org/dp/interval/")[#text("OI Wiki：区间 DP")]。



]
