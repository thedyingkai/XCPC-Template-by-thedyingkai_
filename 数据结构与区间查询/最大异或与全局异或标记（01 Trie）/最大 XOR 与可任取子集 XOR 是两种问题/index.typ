#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("最大 XOR 与可任取子集 XOR 是两种问题")] <trick-bit-16>
*问题概述*　#text("给定 ")$n$#text(" 个非负整数，区分两个目标：①")$n≥2$#text(" 时恰选两个不同下标求 XOR 最大值；②任取一个下标子集求 XOR 最大值，允许空集。两个目标分别要求只使用两原数和允许使用任意多个原数，不能互换算法。")

*必要思路*　#text("两个现有数用 01 Trie 高位贪心找反位；任意子集用线性基消元。线性基会生成输入中不存在的组合值，不能代替 Trie 解“恰好两个原数”。有下标限制时查询前只插合法下标。")

*参考*　#link("https://oi-wiki.org/math/linear-algebra/basis/")[#text("OI Wiki：线性基")]。



]
