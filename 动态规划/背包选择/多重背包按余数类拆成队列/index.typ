#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("多重背包按余数类拆成队列")] <trick-dp-09>
*问题概述*　#text("给定 ")$n$#text(" 类物品，第 ")$i$#text(" 类每件重量 ")$w_i>0$#text("、价值 ")$v_i$#text("，可选件数为整数 ")$0…c_i$#text("。背包容量 ")$K$#text("，允许空选及不装满，求重量不超过 ")$K$#text(" 的最大价值；要求每类转移不再枚举所有可选件数。")

*必要思路*　#text("容量写成 ")$r+k w$#text("。在同一余数 ")$r$#text(" 内，转移化为 ")$k v+max(op("dp")_op("old")_(r+t w)-t v)$#text("，")$t∈[k-c,k]$#text("，用滑动最大值队列。每种物品 ")$O$#text("(容量)；读旧层，避免错误复用。")

*实现提示*　#text("例：重量 w>0、价值 ")$v$#text("、最多 ")$c$#text(" 件，容量至多 ")$K$#text("。old 是上一类物品结束后的数组；每个余数单独清空队列。恰好容量模式跳过不可达 old 状态。每类 ")$O(K)$#text("。")

*伪代码*（需结合题目接口实现）

#trick-code("for r = 0..min(w-1, K):\n  deque q = empty  // stores (index, value)\n  for t = 0..floor((K-r)/w):\n    while q not empty and q.front.index < t-c:\n      q.pop_front()\n    if old[r+t*w] is reachable:\n      value = old[r+t*w] - t*v\n      while q not empty and q.back.value <= value:\n        q.pop_back()\n      q.push_back((t, value))\n    new[r+t*w] = -INF\n    if q not empty:\n      new[r+t*w] = t*v + q.front.value")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/knapsack.html")[#text("CP-Algorithms：背包")]。



]
