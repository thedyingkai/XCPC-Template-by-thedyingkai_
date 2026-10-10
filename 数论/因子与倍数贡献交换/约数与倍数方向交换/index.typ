#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("约数与倍数方向交换")] <trick-math-12>
*问题概述*　#text("给定 ")$n$#text(" 个有编号正整数 ")$a_i≤V$#text("，")$V$#text(" 可接受按值域枚举。对每个 ")$1≤d≤V$#text("，求满足 ")$gcd(a_i,a_j)=d$#text(" 的不同下标无序对数量；重复数值仍按下标区分，本模型不包含 0。")

*必要思路*　#text("先按精确数值计数，再枚举 ")$d$#text(" 的所有倍数累计 ")$op("cntDiv")_(d)$#text("；总访问次数 ")$O(V log V)$#text("。两数 gcd恰为")$d$#text(" 可从大到小，用 ")$binom(op("cntDiv")_(d),2)$#text(" 减掉更大倍数的答案。输入 0 会被所有 ")$d$#text(" 整除，须另处理。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
