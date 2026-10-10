#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("正难则反：总数减非法数")] <trick-misc-01>
*问题概述*　#text("给定长度 ")$n≥0$#text("、字母表大小 ")$m≥1$#text(" 的有序字符串模型，以及一个指定字符 ")$c$#text("，求至少包含一次 ")$c$#text(" 的字符串数量。不附加其他限制，允许按模数输出；")$n=0$#text(" 时空串不满足“至少一次”。多种非法条件的扩展必须处理交集。")

*必要思路*　#text("先数全部，再数补集。例如至少一个指定字符出现=全部字符串-完全不出现。多个非法条件有交集时做容斥或重新分类，不能把各非法数直接相加。具体总数与计数域要一致。")

*参考*　#link("https://cp-algorithms.com/combinatorics/inclusion-exclusion.html")[#text("CP-Algorithms：容斥原理")]。



]
