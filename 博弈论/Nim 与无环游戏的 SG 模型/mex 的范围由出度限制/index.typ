#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("mex 的范围由出度限制")] <trick-game-08>
*问题概述*　#text("给定有限无环公平游戏的一处状态 ")$s$#text("，其合法后继至多 ")$d$#text(" 个，后继 SG 已知且可能很大。要求计算 ")$op("sg")(s)=op("mex")(op("sg")(t))$#text("，并控制单次标记数组的大小，不要求所有局面的总状态数也为 ")$O(d)$#text("。")

*必要思路*　#text("一个含至多 ")$d$#text(" 个数的集合，其 ")$op("mex")≤d$#text("。单次只标记 ")$0 dots.h d$#text(" 即可，超过 ")$d$#text(" 的后继 SG 不影响 mex；用时间戳避免重复清空。SG 小不等于状态数少，两者要分别估算。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
