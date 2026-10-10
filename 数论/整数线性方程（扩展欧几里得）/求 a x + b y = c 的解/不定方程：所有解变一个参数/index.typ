#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("不定方程：所有解变一个参数")] <trick-math-03>
*问题概述*　#text("给定整数 a,b,c，以及有限整数区间 ")$[L_x,R_x]$#text("、")$[L_y,R_y]$#text("，求满足 ")$a x+b y=c$#text("、")$L_x≤x≤R_x$#text("、")$L_y≤y≤R_y$#text(" 的整数对 (x,y) 数量。")$a$#text(" 或 ")$b$#text(" 可以为 0，两个系数全为 0 时也必须按区间大小处理。")

*必要思路*　#text("")$g=gcd(a,b)$#text(" 不整除 ")$c$#text(" 则无解；求一组解后 ")$x=x_(0)+(b/g)t$#text("、")$y=y_(0)-(a/g)t$#text("，把两组范围化为 ")$t$#text(" 的整数区间并取交。需正确实现负数 ")$floor/ceil$#text(" 除法；")$a=0$#text(" 或 ")$b=0$#text(" 单独处理。")

*参考*　#link("https://cp-algorithms.com/algebra/linear-diophantine-equation.html")[#text("CP-Algorithms：不定方程")]。



]
