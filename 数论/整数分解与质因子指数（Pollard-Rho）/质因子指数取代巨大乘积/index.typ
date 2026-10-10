#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("质因子指数取代巨大乘积")] <trick-math-34>
*问题概述*　#text("给定若干正整数因子 ")$A_1…A_m$#text("，其乘积 ")$P$#text(" 可能无法直接存储。求 ")$P$#text(" 的正约数个数、是否为完全平方数，以及十进制末尾零的数量；约数个数可按模数输出，但判断平方和末尾零必须使用实际指数信息。")

*必要思路*　#text("分解各因子并累加质因子指数：约数个数为 ")$product (e+1)$#text("，平方要求每个 ")$e$#text(" 为偶数，十进制末尾零为 min(e2,e5)。阶乘 ")$p$#text(" 指数用 ")$sum  floor(n/p^k)$#text("。若只需判平方，可仅记指数奇偶。")

*参考*　#link("https://cp-algorithms.com/algebra/divisors.html")[#text("CP-Algorithms：约数个数与约数和")]。



]
