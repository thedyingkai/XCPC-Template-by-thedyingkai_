#let render(code) = [
#heading(level: 2, outlined: true)[阈值连通性（Kruskal 重构树）] <book-kruskal-tree>

将无向图的合并过程存成重构森林，适合在线瓶颈路、阈值连通块和块内统计。原点 `1..n`，每次合并新建父节点，`val` 为边权，总节点至多 `2*n-1`。

- `ascending=true` 升序建树，`mergeValue(u,v)` 为所有路径中最大边的最小值；降序则为最小边的最大值。
- `lca(u,v)` 不连通返回 0，`mergeValue` 不连通返回 `nullopt`。同点返回叶子无穷哨兵，须单独定义题目答案。
- `componentNode(u,limit)` 升序时返回只留 `<=limit` 边的块节点，降序时对应 `>=limit`；`leaves[node]` 为原点数量。

相同边权可任意合并，但阈值查询须跳到满足条件的最高祖先。排序加倍增预处理为 $O(m log m+n log n)$，查询 $O(log n)$，空间 $O(m+n log n)$。若只需一批离线阈值询问，直接排序后并查集即可。

#code("图论/阈值连通性（Kruskal 重构树）/Kruskal 重构树.cpp")


]
