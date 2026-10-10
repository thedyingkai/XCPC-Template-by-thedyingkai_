#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("不用真的做加法：和与异或的进位")] <trick-bit-05>
*问题概述*　#text("给定非负整数 ")$S$#text("、")$X$#text("，判断是否存在两个非负整数 ")$a$#text("、")$b$#text("，使 ")$a+b=S$#text(" 且 ")$a op("xor") b=X$#text("，并在存在时构造一组。本条不要求 ")$a$#text("、")$b$#text(" 都为正、不要求互异，也不附加上界。")

*必要思路*　#text("")$a+b=(a op("xor") b)+2(a op("and") b)$#text("，故需 ")$S≥X$#text("、S-X 偶数，并令 ")$C=(S-X)/2$#text(" 满足 ")$C op("and") X=0$#text("；可取 ")$a=C$#text("、")$b=C+X$#text("。若要求都正或加其他上界，需额外处理。先扩宽类型避免求差与乘法溢出。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
