#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("整除子数组：前缀余数相同")] <trick-math-01>
*问题概述*　#text("给定整数数组 ")$a_1…a_n$#text(" 和正整数 ")$m$#text("，求非空连续子数组 [l,r] 的数量，使 ")$sum _(i=l)^r a_i$#text(" 是 ")$m$#text(" 的倍数。数组允许负数，按不同端点对计数，0 也是 ")$m$#text(" 的倍数。")

*必要思路*　#text("前缀和 ")$p_(r)-p_(l-1)≡0 mod m$#text(" 等价于两前缀余数相同。扫描时累计相同余数次数，初始余数 0 的次数为 1；负数余数用 ")$(x mod m+m) mod m$#text(" 归一化，")$m$#text(" 必须正。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
