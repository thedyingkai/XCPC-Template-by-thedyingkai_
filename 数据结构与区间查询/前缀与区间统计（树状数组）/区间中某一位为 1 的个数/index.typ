#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("区间中某一位为 1 的个数")] <trick-bit-22>
*问题概述*　#text("给定非负整数 ")$L≤R$#text(" 和位号 ")$b≥0$#text("，二进制最低位编号为 0。求区间内满足 ")$((x op(">>") b) op("&") 1)=1$#text(" 的整数 ")$x$#text(" 的数量，按整数计数；要求显式控制 ")$2^(b+1)$#text(" 与 ")$R+1$#text(" 的中间溢出。")

*必要思路*　#text("")$0 dots.h x$#text(" 中该位周期为 ")$2^(b+1)$#text("，每周期后一半为 1：令 ")$m=x+1$#text("、")$h=2^b$#text("，数量")$=(m/(2h))h+max(0,m mod (2h)-h)$#text("。区间做前缀差。最大位的 2h 与 ")$x+1$#text(" 可能溢出，必要时用 128 位。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
