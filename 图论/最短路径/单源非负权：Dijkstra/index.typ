#let render(code) = [
#heading(level: 3, outlined: true)[单源非负权：Dijkstra] <book-dijkstra>

非负边权单源最短路，点号 `1..n`。`add(u,v,w)` 加有向边，要求 `0<=w<INF`；无向边加两次。`dij(src)` 重置距离、访问标记与前驱。

不可达距离为 `INF`，`get_path(t)` 返回空数组；可达时沿 `parent` 恢复路径。所有须保留的真实最短路严格小于 `INF`。堆版空间 $O(n+m)$，时间通常记 $O((n+m)log n)$，保留任意多平行边的重复堆项时可按 $O((n+m)log(n+m))$ 估计。

多源时全部源以距离 0 入堆；只求某终点可在其首次有效出堆时停。负边改 Bellman–Ford，DAG 可按拓扑序松弛。

统计最短路条数：更短则覆盖、相等则累加；含零权边时须另处理最短路子图的同距依赖与零环，不能只按出堆顺序累计。

题目：#link("https://judge.yosupo.jp/problem/shortest_path")[Shortest Path]。

#code("图论/最短路径/单源非负权：Dijkstra/Dijkstra.cpp", mode: "full", ignore-main: false)


]
