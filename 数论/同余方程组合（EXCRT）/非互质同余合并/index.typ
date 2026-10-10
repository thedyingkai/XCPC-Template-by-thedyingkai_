#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("非互质同余合并")] <trick-math-06>
*问题概述*　#text("给定两个同余式 ")$x≡a (mod m)$#text("、")$x≡b (mod n)$#text("，其中 m,n>0 且不要求互质。判断是否有整数解，若有则输出最小非负解与所有解的周期 ")$lcm(m,n)$#text("；多式版本按相同规则逐条合并。")

*必要思路*　#text("令 ")$x=a+m t$#text("，解 ")$m t≡b-a mod n$#text("；")$g=gcd(m,n)$#text(" 必须整除 b-a。合并后模数为 ")$lcm(m,n)$#text("，解归一化。用扩展 gcd 求 ")$t$#text("；多式逐条合并，乘法与 lcm 可能超过 64 位。")

*参考*　#link("https://cp-algorithms.com/algebra/chinese-remainder-theorem.html")[#text("CP-Algorithms：中国剩余定理")]。



]
