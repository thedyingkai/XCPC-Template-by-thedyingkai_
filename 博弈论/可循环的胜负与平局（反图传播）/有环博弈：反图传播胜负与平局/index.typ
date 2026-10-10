#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("有环博弈：反图传播胜负与平局")] <trick-game-14>
*问题概述*　#text("给定有限有向图和棋子起点，双方轮流沿一条出边移动棋子。轮到某人时当前点无出边则该人输，无限行动判平局。每人优先争取胜利，其次平局，最后失败；求每个起点在最优策略下的胜、负或平局状态。")

*必要思路*　#text("从终点 ")$P$#text(" 开始在反图上传播：有边到 ")$P$#text(" 的前驱变 ")$N$#text("；全部后继已是 ")$N$#text(" 的前驱变 ")$P$#text("。维护剩余未判后继数。最后未判状态为可保证不败的平局区域；不是“某点在环里就平局”。")

*实现提示*　#text("默认无合法行动者输，永远行动视为平局。rev 是反向边，remain 初值等于出度；按边计数，多重边也按同一口径处理。")$O(V+E)$#text("。")

*伪代码*（需结合题目接口实现）

#trick-code("state[all] = UNKNOWN; remain[u] = outdegree(u)\nqueue all u with remain[u] == 0; state[u] = LOSE\nwhile queue not empty:\n  u = queue.pop()\n  for p in rev[u]:\n    if state[p] != UNKNOWN: continue\n    if state[u] == LOSE:\n      state[p] = WIN; queue.push(p)\n    else:\n      remain[p] -= 1\n      if remain[p] == 0:\n        state[p] = LOSE; queue.push(p)\nUNKNOWN states are DRAW")

*参考*　#link("https://cp-algorithms.com/game_theory/games_on_graphs.html")[#text("CP-Algorithms：有环图上的博弈")]。



]
