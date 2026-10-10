#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("负数最短达标段：前缀单调队列")] <trick-misc-06>
*问题概述*　#text("给定任意整数数组及整数阈值 ")$K$#text("，求和至少 ")$K$#text(" 的非空连续子数组的最短长度，等号计入。元素和 ")$K$#text(" 均可为负，若不存在合法区间则报告无解，不能把长度 0 的空段算入。")

*必要思路*　#text("在前缀和 ")$p$#text(" 上维护递增队列。当前 ")$p_(r)-p_(op("front"))≥K$#text(" 时更新长度并弹头；队尾若 ")$p_(op("back"))≥p_(r)$#text(" 则被当前更晚且更小的前缀支配，弹尾。每个前缀至多入出一次，")$O(n)$#text("。检查非空，比较差值用宽类型。自行推导。")

*实现提示*　#text("求和至少 ")$K$#text(" 的最短非空子数组，允许负数；")$P$#text(" 是 64 位前缀和。必须先查询再插入当前下标，否则 ")$K<=0$#text(" 时会误计空区间。")$O(n)$#text("。")

*伪代码*（需结合题目接口实现）

#trick-code("deque q = empty; best = INF\nfor j = 0..n:\n  while q not empty and P[j]-P[q.front()] >= K:\n    best = min(best, j-q.front()); q.pop_front()\n  while q not empty and P[q.back()] >= P[j]:\n    q.pop_back()\n  q.push_back(j)\nreturn no_solution if best == INF else best")

*依据*　自行推导/归纳，理由已写在思路中。



]
