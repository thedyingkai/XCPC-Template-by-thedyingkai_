#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("固定左端点的 AND／OR 可跳变化点")] <trick-bit-14>
*问题概述*　#text("给定 ")$W$#text(" 位非负整数数组，固定左端点 ")$l$#text("，求 ")$sum _(r=l)^n op("and")(a_l…a_r)$#text("，或对应的 OR 总和。已能快速查询任意区间的 ")$op("and")/op("or")$#text("，要求把连续相同结果的右端点段一次计入，不逐个枚举 ")$r$#text("。")

*必要思路*　#text("用稀疏表或区间结构查询 ")$op("and")/op("or")$#text("，通过单调性二分当前值能保持到的最远右端点，一次处理整段。每个端点最多 ")$O(W)$#text(" 种结果；XOR 不单调，不能照用变化段方法。自行推导。")

*参考*　#link("https://cp-algorithms.com/data_structures/sparse-table.html")[#text("CP-Algorithms：Sparse Table")]。



]
