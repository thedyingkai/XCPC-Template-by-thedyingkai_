#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("折半枚举：两个指数各小一半")] <trick-misc-24>
*问题概述*　#text("给定 ")$n$#text("≈40 个非负整数和容量 ")$C≥0$#text("，每个下标至多选一次，允许空集。求不超过 ")$C$#text(" 的最大子集和；重复数值仍是不同物品，没有跨两半的额外兼容条件。")

*必要思路*　#text("拆两半枚举子集和，排序一半，另一半逐个二分补值；约 ")$O(2^(n/2)log 2^(n/2))$#text("。要计数就保留频次，求最优需维护支配关系；跨两半还有复杂约束时，不能只留和。")

*参考*　#link("https://oi-wiki.org/search/bidirectional/")[#text("OI Wiki：双向搜索与折半搜索")]。



]
