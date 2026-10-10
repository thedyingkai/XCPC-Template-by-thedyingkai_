#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("三角形不等式先排最大边")] <trick-math-26>
*问题概述*　#text("给定 ")$n$#text(" 个有编号的正整数边长 ")$a_i$#text("，统计不同下标无序三元组 i<j<k，使三边可构成非退化三角形。相等长度允许，边长之和比较必须严格大于第三边，不能把退化情形计入。")

*必要思路*　#text("正边长排序，固定最大边 ")$c$#text("，对较小两边用双指针判断 ")$a+b>c$#text("；若成立，当前右端与一段左端都合法，一次计数。退化三角形用严格大于，和先扩宽。零/负数不能当一般边长。自行推导。")

*参考*　#link("https://oi-wiki.org/misc/two-pointer/")[#text("OI Wiki：双指针")]。



]
