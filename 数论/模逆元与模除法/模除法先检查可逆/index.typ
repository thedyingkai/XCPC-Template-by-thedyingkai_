#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("模除法先检查可逆")] <trick-math-04>
*问题概述*　#text("给定整数 ")$a$#text(" 和模数 ")$m≥2$#text("，求满足 ")$a x≡1 (mod m)$#text(" 的最小非负整数 ")$x$#text("，不存在则报告无逆元。若整式在取模前含除法，必须区分“整数商存在”和“分母在模 ")$m$#text(" 下可逆”，不能直接等同。")

*必要思路*　#text("逆元存在当且仅当 ")$gcd(a,mod)=1$#text("；一般用扩展欧几里得。素数模下费马逆元仍要求 ")$a$#text("不为0 mod p。不可逆不意味着原整数公式不存在，可能须先做整除、拆素数幂或保留因子指数。")

*参考*　#link("https://cp-algorithms.com/algebra/module-inverse.html")[#text("CP-Algorithms：模逆元")]。



]
