#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("扫描线端点顺序就是区间语义")] <trick-misc-16>
*问题概述*　#text("给定多组实数坐标闭区间 ")$[l_i,r_i]$#text("，求任一点处被覆盖的最大区间数，端点也算覆盖，零长度区间有效。若改为半开区间 [l_i,r_i)，右端点不覆盖且空区间无贡献；两种语义必须分别规定同坐标事件顺序。")

*必要思路*　#text("闭区间含左右端点，同坐标先加入再查询/删除；半开 [l,r) 在 ")$r$#text(" 已失效，应先删除再查询。覆盖连续长度时只在相邻坐标间乘活动覆盖状态，孤立端点长度为 0。整数闭区间可变 [l,r+1)，")$r+1$#text(" 注意溢出。")

*参考*　#link("https://oi-wiki.org/basic/prefix-sum/")[#text("OI Wiki：前缀和与差分")]。



]
