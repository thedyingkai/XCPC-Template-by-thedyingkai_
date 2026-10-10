#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("优化 AND 答案：高位试着保留")] <trick-bit-15>
*问题概述*　#text("给定 ")$n$#text(" 个 ")$W$#text(" 位非负整数和整数 ")$1≤k≤n$#text("，恰选 ")$k$#text(" 个不同下标，使所选元素的按位 AND 值最大，求该最大值。除了选择个数外没有下标、和、邻接等额外约束；")$k=2$#text(" 是两数版本。")

*必要思路*　#text("从高位到低位试设 ")$op("cand")=op("ans")|(1 op("<<") b)$#text("，数满足 ")$(a_(i) op("&") op("cand"))==op("cand")$#text(" 的个数；至少 ")$k$#text(" 个就接受。该集合包含全部已接受位，且数值高位优先，所以贪心成立。若还要求两数和等约束，单纯数个数不够。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
