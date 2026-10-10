#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("数对异或和拆成每一位")] <trick-bit-02>
*问题概述*　#text("给定 ")$n$#text(" 个 ")$W$#text(" 位非负整数 ")$a_i$#text("，求 ")$sum _(1≤i<j≤n)(a_i op("xor") a_j)$#text("，运算顺序是先对每个数对异或再把结果相加。下标不同但值相同也计为一个数对，不计有序重复或自身配对。")

*必要思路*　#text("第 ")$b$#text(" 位有 ")$c$#text(" 个 1、n-c 个 0，贡献 ")$c(n-c)2^b$#text("。按位相加，")$O(n W)$#text("，无需枚举数对。若有序则乘 2，求 XOR 后再求和可拆位，但“异或值乘积”等跨位非线性目标不能照套。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
