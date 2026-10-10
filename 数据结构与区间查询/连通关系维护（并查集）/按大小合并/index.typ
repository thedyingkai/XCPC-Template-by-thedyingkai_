#let render(code) = [
#heading(level: 3, outlined: true)[按大小合并] <book-variant-001>

维护只合并、不拆分的集合，适用于连通性、Kruskal 和倒序加边。路径压缩配合按大小合并，单次操作均摊 $O(alpha(n))$，空间 $O(n)$。

- `DSU(n)`：点号 `0..n-1`；用 `1..n` 时构造 `DSU(n+1)`。
- `find(x)` 返回代表元；`size(x)` 返回块大小。
- `unite(a,b)` 返回是否发生合并。块数初值为实际点数，仅成功合并后减一。

块权、边数等附加信息存在根上，合并时更新。Kruskal 仅在合并成功时选边；倒序删边先建最终图，再逆序恢复。当前 `find` 会压缩路径，需要回滚时换用可撤销并查集。

题目：洛谷 P3367、P1197；#link("https://judge.yosupo.jp/problem/unionfind")[Unionfind]。

#code("数据结构与区间查询/连通关系维护（并查集）/按大小合并/按大小合并.cpp")


]
