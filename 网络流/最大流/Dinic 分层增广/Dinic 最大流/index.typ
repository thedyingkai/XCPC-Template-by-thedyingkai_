#let render(code) = [
#heading(level: 4, outlined: true, numbering: none)[Dinic 最大流]

`Dinic(n,S,T)` 使用 `0..n`，源汇不同；`add(u,v,c)` 加非负容量有向原边并补零容量反边。`dinic()` 返回从当前残量图新增的流量，重复调用时调用方自行累计。

一般图时间 $O(V^2E)$，空间 $O(V+E)$。BFS 分层，DFS 只沿层数增加一的边推阻塞流，直到源汇不再连通。DFS 为递归，深层网络须调整栈或改显式实现。

正反边编号为 `id` 与 `id^1`。保存原正向编号后，反容量即该原边流量。若只判能否达到 `k`，将瓶颈截到剩余需求并提前停；这种提前停止状态不能直接用于最小割。

容量、推流量、总答案均为 `i64`，总量须不溢出。

#code("网络流/最大流/Dinic 分层增广/Dinic 最大流/Dinic 最大流最小割.cpp", mode: "full")


]
