#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("数位 DP 记录数量与总和")] <trick-dp-24>
*问题概述*　#text("给定非负整数 ")$L≤R$#text(" 及有限数位状态规则，求该区间内所有合法整数的数值总和，而非仅求数量。允许要求对指定模数取模；前导零和整数 0 的合法性须与计数版本保持一致。")

*必要思路*　#text("每个状态维护合法前缀数量 ")$c$#text(" 及这些前缀数值之和 ")$s$#text("。十进制接入一位 ")$d$#text(" 后，本次转移对新状态贡献 ")$c'=c, quad s'=10 s+c d$#text("，再将所有合法转移的贡献相加。最终将合法终态的总和汇总即可。无需把完整数值开为状态；若还求平方和，需要额外二阶矩并展开 ")$(10x+d)^2$#text("。")

*参考*　#link("https://oi-wiki.org/dp/number/")[#text("OI Wiki：数位 DP")]。



]
