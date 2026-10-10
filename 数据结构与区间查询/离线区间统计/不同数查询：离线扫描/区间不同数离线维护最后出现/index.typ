#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("区间不同数离线维护最后出现")] <trick-misc-07>
*问题概述*　#text("给定静态数组及 ")$q$#text(" 个闭区间询问 ")$[l_i,r_i]$#text("，每次返回区间内不同数值的种类数。允许重复数值，期间没有数组修改；询问可以离线处理，但输出必须恢复原输入顺序。")

*必要思路*　#text("询问按 ")$r$#text(" 排序，扫描到 ")$r$#text(" 时把 ")$a_(r)$#text(" 的上次位置从 1 改 0，当前改 1；树状数组查 ")$l dots.h r$#text("。每种值恰留最后一次出现，位于区间就代表该值存在。回答后按询问 ID 还原顺序。自行推导。")

*实现提示*　#text("静态区间不同数个数，询问按右端点排序。BIT 用 ")$1-op("based")$#text(" 下标，last 默认 0；")$O((n+q)log n)$#text("。同值原位置删除后再标记新位置。")

*伪代码*（需结合题目接口实现）

#trick-code("pos = 0; BIT = zero; last = empty map\nfor query (l,r,id) sorted by r:\n  while pos < r:\n    pos += 1; x = a[pos]\n    if last.get(x,0) != 0: BIT.add(last[x], -1)\n    BIT.add(pos, +1); last[x] = pos\n  answer[id] = BIT.sum(r) - BIT.sum(l-1)")

*参考*　#link("https://cp-algorithms.com/data_structures/fenwick.html")[#text("CP-Algorithms：树状数组")]。



]
