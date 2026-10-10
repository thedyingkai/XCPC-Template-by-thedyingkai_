#import "set 优化 Prim/index.typ" as section-0
#import "堆优化 Prim/index.typ" as section-1
#import "Kruskal/index.typ" as section-2
#import "Borůvka 异或最小生成树/index.typ" as section-3
#import "严格次小生成树/index.typ" as section-4

#let render(code) = [
#heading(level: 2, outlined: true)[最小生成树（MST）] <book-mst>

无向图中选 `n-1` 条边连通全部点，最小化总权。Kruskal 适合直接给边集，排序 $O(m log m)$；`set` Prim 为 $O((n+m)log n)$，堆 Prim 常按 $O(m log n)$ 估计，任意多重边时可按 $O((n+m)log(n+m))$。

*接口*　三份都在构造时求解，先判 `f`，成功才读取 MST 权值 `ans`。Prim 默认从 1 出发，无向边存两次，`parent[v],d[v]` 是所选边；`prim(s)` 可重置并换起点。Kruskal 原边存一次，会原地排序输入。

不连通时 Kruskal 得最小生成森林，Prim 只覆盖起点分量。单边为 `int`、总和为 `i64`，扩大边权范围须同步改邻接表和 `Edge::w`。输出原边号时给边加 `id`，选中时记录；重边不能只凭端点反查。

*变体*

- 最大生成树：Kruskal 降序；Prim 同步改初值、比较与堆。
- 最小瓶颈路等于 MST 路径最大边；最大瓶颈路等于最大生成树路径最小边。瓶颈最优不等于距离和最短。
- 严格次小：枚举非树边替换，路径存最大和严格次大。
- MST 计数：按权值成组，缩小权边形成的块，在同权子图中用矩阵树定理，处理完该组再合并。
- 最小权差生成树：排序后枚举允许边权窗口，判窗口图能否连通；需要支持删边的结构或重新判定。

题目：P1967；#link("https://judge.yosupo.jp/problem/minimum_spanning_tree")[Minimum Spanning Tree]。


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

#section-4.render(code)

]
