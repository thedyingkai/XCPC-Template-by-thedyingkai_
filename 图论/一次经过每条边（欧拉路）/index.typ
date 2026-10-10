#let render(code) = [
#heading(level: 2, outlined: true)[一次经过每条边（欧拉路）] <book-euler-route>

每条边恰走一次，Hierholzer 时间、空间 $O(n+m)$。`Euler(n,true)` 有向，`false` 无向；无向边只 `add` 一次。

`trail()` 自动选起点，`trail(start)` 指定起点；成功返回 `m+1` 个顶点，失败返回空数组。度数条件满足后，代码还检查用边数是否等于 `m`，排除边落在多个不连通部分。

- 有向开路：起点出度减入度为 1，终点为 −1，其余为 0；回路全部为 0。
- 无向开路：恰有两个奇度点，从其中一个出发；回路无奇度点。

算法沿未用边前进，走不动时退栈记录，最后逆序。无向边的两个邻接项共享边号。需要边号或标签时，在栈中记录进入边；字典序最小须排序邻接表，并显式选择合适起点。

题目：#link("https://judge.yosupo.jp/problem/eulerian_trail_directed")[有向欧拉路]、#link("https://judge.yosupo.jp/problem/eulerian_trail_undirected")[无向欧拉路]。

#code("图论/一次经过每条边（欧拉路）/欧拉路.cpp")


]
