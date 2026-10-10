#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("第 K 小不必显式列出全部候选")] <trick-misc-22>
*问题概述*　#text("给定 ")$n m$#text(" 乘法表，单元值为 ")$i j$#text("，")$1≤i≤n$#text("、")$1≤j≤m$#text("，给定 ")$1≤K≤n m$#text("。把全部单元值按含重复项的多重集排序，求第 ")$K$#text(" 小值；两个不同单元即使数值相同也分别计入排名。")

*必要思路*　#text("二分 ")$X$#text("，统计")$≤X$#text(" 的候选数 ")$C(X)$#text("，找到 ")$C(X)≥K$#text(" 的最小 ")$X$#text("。计数器可在到 ")$K$#text(" 后截断避免溢出；元素可重复时按多重集计数。若计数仍是二次且无法优化，二分本身并未解决瓶颈。")

*参考*　#link("https://oi-wiki.org/basic/binary/")[#text("OI Wiki：二分")]。



]
