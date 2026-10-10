#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("所有子数组的异或值之和")] <trick-bit-03>
*问题概述*　#text("给定 ")$W$#text(" 位非负整数数组 ")$a_1…a_n$#text("，求全部非空连续子数组的 XOR 值的算术总和 ")$sum _(1≤l≤r≤n)(a_l op("xor") … op("xor") a_r)$#text("，而非把各区间结果再进行一次 XOR。")

*必要思路*　#text("先得到 ")$n+1$#text(" 个前缀 XOR，按每一位数 0、1 前缀数，贡献 ")$c_0 c_1 2^b$#text("。每对前缀唯一对应一个非空区间，所以无序配对即可。与“所有区间 XOR 的 XOR”不同，后者是每个元素被包含次数的奇偶。")

*参考*　#link("https://www.luogu.com.cn/article/f3jhcq3e")[#text("洛谷 critnos：位运算技术")]。



]
