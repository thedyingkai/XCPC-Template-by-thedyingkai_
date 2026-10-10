#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("Gray Code：枚举时只改一个元素")] <trick-bit-24>
*问题概述*　#text("给定 ")$n$#text(" 个元素和可维护的集合代价 f(S)，加入或移除单个元素能快速更新。要求枚举全部 ")$2^n$#text(" 个下标集合且每个一次，枚举过程中相邻两个集合只改变一个元素；不要求按二进制数值递增输出。")

*必要思路*　#text("以 ")$g(i)=i op("xor")(i op(">>") 1)$#text(" 的 Gray 顺序枚举，相邻掩码恰差一位；对两个掩码 XOR 后定位该位，执行一次增删更新。总状态仍 ")$2^n$#text("，只减少更新成本；")$n$#text(" 必须能放入所用整数且可承受枚举量。")

*参考*　#link("https://cp-algorithms.com/algebra/gray-code.html")[#text("CP-Algorithms：Gray Code")]。


参见 #link(<book-subset-transform>)[子集和查询的 SOS／Zeta 变换]。


]
