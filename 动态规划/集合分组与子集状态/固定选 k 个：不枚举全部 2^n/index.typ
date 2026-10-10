#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("固定选 k 个：不枚举全部 2^n")] <trick-bit-09>
*问题概述*　#text("给定整数 ")$0≤k≤n$#text("，从有编号的 ")$n$#text(" 个元素中恰选 ")$k$#text(" 个，枚举所有下标集合且不重复。希望只生成 ")$binom(n,k)$#text(" 个候选，避免遍历全部 ")$2^n$#text(" 个集合；若输出机器字掩码，还须满足 ")$n$#text(" 不超过可用位数。")

*必要思路*　#text("保存递增位置组合 ")$c_(0)<…<c_(k-1)$#text("。从最右找还能增加的位置，加一后把后续位置依次填为最小合法值，再转换成掩码；总生成 ")$binom(n,k)$#text(" 个组合，朴素每次 ")$O(k)$#text("。")$k=0$#text(" 输出唯一空集，k>n 无解；必要时再学 Gosper 位技巧。")

*参考*　#link("https://cp-algorithms.com/combinatorics/generating_combinations.html")[#text("CP-Algorithms：固定大小组合枚举")]。



]
