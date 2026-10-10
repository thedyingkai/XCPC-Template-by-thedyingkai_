#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("斜率优化先把式子拆成 i、j 两部分")] <trick-dp-27>
*问题概述*　#text("给定前缀量 ")$s_0=0,s_1…s_n$#text("、常数 ")$C$#text(" 和 ")$op("dp")_0=0$#text("。按 ")$i$#text(" 递增计算 ")$op("dp")_i=min_(0≤j<i)(op("dp")_j+(s_i-s_j)^2+C)$#text("，求 ")$op("dp")_n$#text("。")$s_i$#text(" 是否单调必须从输入条件判断，不能在使用单调凸包时额外假设。")

*必要思路*　#text("展开为 ")$s_(i)^2+C+min_j((-2s_(j))s_(i)+op("dp")_(j)+s_(j)^2)$#text("，每个 ")$j$#text(" 是一条直线。斜率和查询点单调时可用单调凸包；否则考虑李超树或可二分查询的凸包。交叉乘积用足够宽整数。")

*参考*　#link("https://oi-wiki.org/dp/opt/slope/")[#text("OI Wiki：斜率优化")]。


参见 #link(<book-li-chao>)[李超树代码与整数查询范围]。


]
