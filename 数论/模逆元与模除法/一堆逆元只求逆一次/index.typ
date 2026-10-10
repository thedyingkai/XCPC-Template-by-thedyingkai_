#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("一堆逆元只求逆一次")] <trick-math-05>
*问题概述*　#text("给定模数 ")$m≥2$#text(" 及 ")$n$#text(" 个整数 ")$a_i$#text("，保证 ")$gcd(a_i,m)=1$#text("。求全部 ")$a_i$#text(" 的模逆元，希望只进行一次扩展欧几里得或求逆快速幂，其余步骤为 ")$O(n)$#text(" 次模乘；元素不要求互异。")

*必要思路*　#text("做前缀乘积 ")$P$#text("，求总积逆元一次，再逆序求每个逆元：")$op("inv")(a_(i))=P_(i-1) op("inv")(P_(i))$#text("，随后乘 ")$a_(i)$#text(" 推回。要求每个 ")$a_(i)$#text(" 都是单位；混入不可逆元素会使总积也不可逆。")

*参考*　#link("https://cp-algorithms.com/algebra/module-inverse.html")[#text("CP-Algorithms：模逆元")]。


参见 #link(<book-combination>)[阶乘与批量逆元代码]。


]
