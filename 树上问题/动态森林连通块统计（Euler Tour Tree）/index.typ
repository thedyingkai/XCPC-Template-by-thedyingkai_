#let render(code) = [
#heading(level: 2, outlined: true)[动态森林连通块统计（Euler Tour Tree）] <book-ett>

维护动态森林的连通性、整块点数与点权和。`EulerTourTree(n)` 使用 `1..n`，初始孤立、点权为 0。单次操作期望 $O(log n)$；成功加边累计 $A$ 次后空间 $O(n+A)$，删边节点不回收。

- `link(u,v)` 加边：自环或已连通返回 `false`。`cut(u,v)` 仅删直接边，不存在返回 `false`。
- `connected(u,v)` 判连通；`setValue(v,w)` 是赋值，单点加须传入更新后的权值。
- `componentSum(v)`、`componentSize(v)` 查询整块。结构要求始终为森林；一般动态图的非树边与替代边须另管。

*子树查询*　已知指定根下 `v` 的父亲 `p` 时，临时 `cut(v,p)`，查询 `v` 所在块，再 `link(v,p)`；`v` 为根则直接查整块。重新连接会分配新边节点。

*修改聚合*　欧拉游走中每条边有两个有向标记，每个顶点只有 `self[v]` 贡献点权。`reroot(v)` 只是循环移动序列；分裂、合并须维护 Treap 父指针。整块和、最大值等可交换信息可直接替换聚合；路径查询用 LCT。

整块加值需另加懒标记：和增加 `delta*vertexCount`，仅顶点标记修改自身值，边标记不贡献。权值和须装入聚合类型。

题目：#link("https://judge.yosupo.jp/problem/dynamic_tree_vertex_add_subtree_sum")[Dynamic Tree Vertex Add Subtree Sum]。

#code("树上问题/动态森林连通块统计（Euler Tour Tree）/Euler Tour Tree.cpp")


]
