#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("数位 DP：把区间变两个前缀")] <trick-dp-23>
*问题概述*　#text("给定非负整数 ")$L≤R$#text(" 以及判定整数合法性的有限数位状态规则，例如数位和模 ")$m$#text("、相邻数位禁配。求 [L,R] 中合法整数个数，按通常十进制表示判断，不把前导零当作实际数位；整数 0 是否合法由规则明确规定。")

*必要思路*　#text("实现 ")$F(x)$#text(" 统计 ")$0 dots.h x$#text("，答案 ")$F(R)-F(L-1)$#text("。状态保存位置、必要性质、tight 和前导零语义；只有已脱离上界的状态才可跨相同上下文复用。")$L=0$#text(" 时定义 ")$F(-1)=0$#text("。")

*参考*　#link("https://oi-wiki.org/dp/number/")[#text("OI Wiki：数位 DP")]。



]
