#let render(code) = [
#heading(level: 4, outlined: true, numbering: none)[Edmonds–Karp 最大流]

`EK(n,S,T)` 建图，`add(u,v,c)` 加有向原边及零容量反边，`ek()` 返回当前残量图新增的流量。每轮 BFS 找边数最少的增广路，沿路统一推瓶颈 `mf[T]`，`pre` 记录进入边。

时间 $O(V E^2)$，空间 $O(V+E)$，适合小网络；大规模最大流用 Dinic。源汇不同，容量非负，总流量须在类型范围内。

恢复方案：建边时保存正向编号，运行后读反容量。只需达到 `k` 时可截瓶颈至剩余需求，满足后停止。

#code("网络流/最大流/EK 增广路/Edmonds–Karp 最大流/EK 最大流.cpp")


]
