#let render(code) = [
#heading(level: 2, outlined: true)[区间连边（线段树优化建图）] <book-range-graph>

压缩点与区间、区间与区间之间的同权有向边。`RangeEdgeGraph(n)` 要求 `n>=1`，原点号 `1..n`，区间闭合，边权非负。

- `addEdge(u,v,w)`：点到点。
- `pointToRange(u,l,r,w)`：`u` 到 `[l,r]` 每点。
- `rangeToPoint(l,r,v,w)`：`[l,r]` 每点到 `v`。
- `rangeToRange(l1,r1,l2,r2,w)`：源区间每点到目标区间每点。
- `dijkstra(s)`：返回原点 `1..n` 的 `i128` 距离，不可达为 `RangeEdgeGraph::INF`，0 号不用。

*边的方向*　出树父到子零权，入树子到父零权，叶子共用原点。点到区间连出树覆盖节点，区间到点连入树覆盖节点。每次区间到区间操作独建中转点：源入树以 0 进入，中转点以 `w` 进入目标出树，整次只付一次权。

双树方向须分开，操作间中转点各自独立，避免产生额外可达关系。结构节点仅压缩路径，统计原题顶点时排除它们。

普通边 $m$ 条、区间操作 $q$ 次，其中区间到区间 $b$ 次时，点数 `N=3*n-2+b`，边数 $M=O(n+m+q log n)$。当前重复入堆 Dijkstra 为 $O((N+M)log(N+M))$，空间 $O(N+M)$；建完可多源分别运行。

来源：wzj52501，#link("https://github.com/wzj52501/awesome-competitive-olympiad-algorithms/blob/c3685028be8ac258074260f8d8bd825faddc4a76/Lectures/Graph-Misc-Problems.pdf")[《图论杂题选讲》46–50 页]。说明文字 CC BY-NC-SA 4.0。

#code("图论/区间连边（线段树优化建图）/线段树优化建图.cpp")


]
