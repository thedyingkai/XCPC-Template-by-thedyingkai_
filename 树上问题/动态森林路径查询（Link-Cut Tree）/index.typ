#let render(code) = [
#heading(level: 2, outlined: true)[动态森林路径查询（Link-Cut Tree）] <book-lct>

维护动态森林的点权与路径聚合。`LinkCutTree(n)` 使用 `1..n`，初始孤立、点权为 0；单次操作均摊 $O(log n)$，空间 $O(n)$。

- `setValue(v,w)` 赋值；`link(u,v)` 加边，产生环时返回 `false`。
- `cut(u,v)` 只删直接边，不存在返回 `false`。
- `connected(u,v)` 判连通；连通后才可 `queryPath(u,v)`，结果含点数、和、最大值、异或和。

*暴露路径*　`makeRoot(u); access(v)` 后，`v` 的辅助树表示有方向的 `u..v` 路径。`parent` 兼作辅助树父亲与路径父亲，须用 `isAuxRoot` 区分；`access` 换下旧右儿子时保留其 `parent`。旋转前从上到下传翻转标记。

*边权转点权*　每条边新建一个点，再连两个端点；删边切断这两个连接。只统计边时，原顶点在和、异或中取 0，在最大值中取负无穷；另存边节点数量，不能直接用当前 `size`。

*常见改法*

- 路径加：暴露后给 `v` 加标记，更新自身值，和增加 `delta*size`，最大值增加 `delta`。现有异或和无法只凭旧值、点数、加数更新，须删去该聚合或另设状态。
- 有方向的矩阵或字符串合并：按“左、自身、右”计算，同时存正序与逆序，翻转时交换。当前 `pull` 利用了可交换性，不能只替换运算符。
- 实树子树和：增加虚子树贡献，`access` 时加入旧右链、扣除新右链，并指定实树根；当前路径接口不含这些信息。

个别操作可超过对数时间，复杂度是整体均摊。权值和及懒标记乘积可能超过 `i64` 时同步扩宽。

题目：洛谷 P3690；#link("https://judge.yosupo.jp/problem/dynamic_tree_vertex_add_path_sum")[Dynamic Tree Vertex Add Path Sum]。

#code("树上问题/动态森林路径查询（Link-Cut Tree）/Link-Cut Tree.cpp")


]
