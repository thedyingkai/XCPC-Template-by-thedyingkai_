#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("固定右端点的 AND／OR 只有少量不同值")] <trick-bit-13>
*问题概述*　#text("给定 ")$W$#text(" 位非负整数数组和目标 ")$K$#text("，统计所有非空连续子数组中按位 AND 恰为 ")$K$#text(" 的个数；OR 版本将全部 AND 换为 OR。要求压缩每个固定右端点的不同区间结果，同时保留各结果对应的区间数量。")

*必要思路*　#text("保存以 ")$r-1$#text(" 结尾的不同值与次数，和 ")$a_(r)$#text(" 做 ")$op("and")/op("or")$#text(" 后合并相邻重复值，再加入单点。延长区间时每位只能从 1→0（AND）或 0→1（OR），所以每个右端点仅 ")$O(W)$#text(" 个值。次数也要聚合。自行推导。")

*实现提示*　#text("例：统计所有子数组 AND 等于 ")$K$#text(" 的个数。cur 保存以当前右端点结束的 (AND值,数量)；相同结果在这一链中连续，可相邻合并。")$O(n W)$#text(" 时间、")$O(W)$#text(" 空间。OR 版本把 & 换成 |。")

*伪代码*（需结合题目接口实现）

#trick-code("cur = empty; answer = 0\nfor x in a:\n  next = [(x, 1)]\n  for (value, count) in cur:\n    y = value & x\n    if next.back.value == y:\n      next.back.count += count\n    else:\n      next.push_back((y, count))\n  cur = next\n  for (value, count) in cur:\n    if value == K: answer += count")

*依据*　自行推导/归纳，理由已写在思路中。



]
