#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("区间 XOR：前缀 0..x 只有四种")] <trick-bit-06>
*问题概述*　#text("给定非负整数 ")$L≤R$#text("，求连续整数 ")$L,L+1,…,R$#text(" 的按位 XOR；区间非空，范围可达 ")$10^18$#text("，要求不逐个枚举整数。")

*必要思路*　#text("")$F(x)=0 op("xor")_(1) op("xor")…op("xor") x$#text("，根据 x mod4 分别是 ")$x$#text("、1、")$x+1$#text("、0，答案 ")$F(R) op("xor") F(L-1)$#text("，定义 ")$F(-1)=0$#text("。可将四个连续整数配对证明；")$x+1$#text(" 要检查类型上界。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
