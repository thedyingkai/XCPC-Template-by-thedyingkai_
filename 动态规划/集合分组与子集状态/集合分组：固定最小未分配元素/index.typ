#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("集合分组：固定最小未分配元素")] <trick-dp-20>
*问题概述*　#text("给定 ")$n$#text(" 个有编号对象，以及每个非空子集 ")$T$#text(" 的单组代价 ")$op("cost")_(T)$#text(" 或合法性。把所有对象恰好划分成若干非空、互不相交的合法组，每个对象属于一组，组之间无顺序。求各组代价之和的最小值；计数变形中也必须把同一无序划分只计一次。")

*必要思路*　#text("令 ")$op("dp")_(S)$#text(" 为恰好划分集合 ")$S$#text(" 的最小代价，")$op("dp")_(0)=0$#text("。枚举包含 ")$S$#text(" 中最低位的合法组 ")$T$#text("，转移为 ")$op("dp")_S=min_(T subset.eq S, b in T)(op("cost")_T+op("dp")_(S without T))$#text("，其中 ")$b$#text(" 是固定元素。固定一组的代表元素，使同一无序划分只生成一次；计数版本把最小值改成方案数求和。总枚举量 ")$O(3^n)$#text("。")

*实现提示*　#text("例：把 ")$n$#text(" 个元素划分为若干无序组，")$op("cost")_(T)$#text(" 是单组代价。固定当前集合的最低位所在组，避免按组排列重复计数。朴素 ")$O(3^n)$#text("，只枚举合法组时可减小常数。")

*伪代码*（需结合题目接口实现）

#trick-code("dp[0] = 0; dp[other masks] = INF\nfor nonempty mask in increasing numeric order:\n  bit = mask & (-mask)\n  rest = mask ^ bit\n  enumerate every submask S of rest, including 0:\n    group = S | bit\n    if group is legal and dp[mask ^ group] reachable:\n      dp[mask] = min(dp[mask],\n                     cost[group] + dp[mask ^ group])")

*参考*　#link("https://oi-wiki.org/dp/state/")[#text("OI Wiki：状压 DP")]。



]
