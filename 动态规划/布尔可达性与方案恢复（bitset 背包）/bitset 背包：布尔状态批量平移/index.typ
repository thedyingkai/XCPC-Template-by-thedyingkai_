#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("bitset 背包：布尔状态批量平移")] <trick-bit-19>
*问题概述*　#text("给定 ")$n$#text(" 件重量为正整数的物品，每件至多选一次，容量 ")$V$#text("。求 0…V 中哪些总重量可由下标子集组成，允许空集；只问可达性，不求价值、最少件数或精确方案数。")

*必要思路*　#text("")$op("bits")_(0)=1$#text("，每个重量 ")$w$#text(" 执行 ")$op("bits")|=op("bits") op("<<") w$#text("，一次位移并 OR 表示完整旧层的转移，约 O(nV/机器字长)。负重量需平移值域并设计双向位移；求最大价值或精确计数不能直接用布尔 bitset。")

*参考*　#link("https://oi-wiki.org/math/bit/")[#text("OI Wiki：位操作")]。



]
