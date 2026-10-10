#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("复合模指数：非互质时不能直接降幂")] <trick-math-35>
*问题概述*　#text("给定非负整数 ")$a$#text("、模数 ")$m≥2$#text("，以及用十进制长串表示的非负指数 ")$E$#text("，求 ")$a^E mod m$#text("。不保证 ")$gcd(a,m)=1$#text("，")$E=0$#text(" 时规定结果为 1 mod m；不能未经判定把 ")$E$#text(" 直接替换为 E mod φ(m)。")

*必要思路*　#text("只有 ")$gcd(a,m)=1$#text(" 才可无条件按欧拉周期降指数。非互质可分解成质数幂，分别跟踪 ")$a$#text(" 的 ")$p$#text(" 因子指数达到模数幂次的时刻，再处理单位部分并 CRT；不要省掉“原指数是否足够大”的信息。自行归纳。")

*参考*　#link("https://cp-algorithms.com/algebra/chinese-remainder-theorem.html")[#text("CP-Algorithms：中国剩余定理")]。



]
