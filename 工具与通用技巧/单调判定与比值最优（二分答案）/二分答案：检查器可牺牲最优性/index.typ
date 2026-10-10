#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("二分答案：检查器可牺牲最优性")] <trick-misc-09>
*问题概述*　#text("给定长度 ")$n$#text(" 的非负整数数组和整数 ")$1≤k≤n$#text("，把数组切为至多 ")$k$#text(" 个非空连续段。求各段元素和的最大值能达到的最小值；不允许重排元素，允许少于 ")$k$#text(" 段，要求精确求整数答案。")

*必要思路*　#text("给定上界 ")$X$#text("，若存在 ")$a_i>X$#text(" 则不可行，否则从左到右贪心尽量延长当前段，下一项使和超过 ")$X$#text(" 时才开新段。非负性保证该策略使用最少段数，段数")$≤k$#text(" 就可行。可行性对 ")$X$#text(" 单调，在 ")$max(a_i)… sum  a_i$#text(" 间二分；输入有负数时这份贪心证明不成立。")

*参考*　#link("https://oi-wiki.org/basic/binary/")[#text("OI Wiki：二分")]。



]
