==== 维护与产物

- 输入一棵树形固定、边权可修改的非负权树，维护整棵树的 cluster DP。
- `setEdge(id,w)` 修改一条边，`diameter()` 直接取当前全树直径。
- 适合固定树上单点或单边修改、全局树 DP 询问；不支持 `link/cut`、链修改或子树修改。

==== 接口与边界

- 边编号是构造时 `treeEdges` 的下标；树形变化用 Link-Cut Tree、Euler Tour Tree 或完整动态 Top Tree。
- 输入必须是 $n >= 1$ 的连通树，边权必须非负；`root` 只改变分解，不改变直径。

==== Cluster 边界

- 叶子 `v` 表示 `parent[v]` 与 `v` 之间的边；根叶子多一条权为 $0$ 的虚边。
- `compress(L,R)` 合并 $(a,b)$ 与 $(b,c)$，新边界为 $(a,c)$。
- `rake(main,side)` 合并 $(a,b)$ 与 $(a,c)$，保留 `main` 的 $(a,b)$，`side` 的右边界在新 cluster 内部化。因此 `rake` 不可随意交换参数。

==== 改 DP

- `Cluster` 的 `length/fromLeft/fromRight/diameter` 分别是两边界距离、从左/右边界出发的最远距离、cluster 内直径。改题时一起替换 `Cluster`、`makeEdge`、`rake`、`compress`。
- 根的虚边会调用 `makeEdge(0)`；新状态必须让它成为合法单位元。有方向的信息要分开左到右和右到左，不能把 `compress` 当成可交换操作。
- 单边修改映射到定根后的子端点叶子，只重算该叶子到 Top Tree 根的祖先；增加可修改数据时也要保留这个定位映射。

==== 板子题

- 固定树形、单边改权、全树直径。
- AtCoder ABC351 G「Hash on Tree」：保留 Top Tree 结构，重写 cluster DP。
- Library Checker「Point Set Tree Path Composite Sum (Fixed Root)」：非交换 `compress` 的典型。
