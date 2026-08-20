Link-Cut Tree 把实树路径动态改造成若干棵 Splay，解决森林中的加边、删边、换根、单点修改和路径聚合。`queryPath(u,v)` 暴露路径后返回点数、和、最大值与异或和；整棵连通块的可交换信息更适合 Euler Tour Tree。

==== 路径暴露

节点的 `parent` 既可能指向辅助树父亲，也可能在当前节点是辅助树根时指向实树中的路径父亲；`isAuxRoot` 用父亲是否把自己列为儿子来区分。`access(x)` 沿实树父链向上：每次把已经处理好的链设为当前点的右儿子，从而改写首选边；结束并 `splay(x)` 后，`x` 的辅助树按中序恰好表示当前实树根到 `x` 的路径。

`makeRoot(x)` 先 `access(x)`，再给整条根到 `x` 的链打翻转标记，于是 `x` 成为实树的新根，森林中的无向边没有变化。代码没有单列 `split` 函数；标准的 `split(u,v)` 就是 `makeRoot(u); access(v)`，此后 `v` 的辅助树信息恰好覆盖路径 `u..v`，`queryPath` 正是这个顺序。

- 非法加边或删除不存在的直接边时，`link/cut` 返回 `false`；`queryPath` 断言两点连通。
- 边权问题把每条边新建成一个点，再把它分别连到两个端点；删除边时切断这两个连接。

==== 改聚合

- 当前聚合量可交换。维护矩阵、字符串等有方向的信息时，节点需同时保存正序和逆序答案，翻转标记交换两者。
- `makeRoot` 只改变辅助树表示，不改变森林中的边；子树信息不能直接由当前路径聚合得到。
- 调用前必须保证点编号在构造范围内；辅助树祖先标记使用显式栈从上到下下传。

- 洛谷 P3690「Link Cut Tree」。
- #link("https://judge.yosupo.jp/problem/dynamic_tree_vertex_add_path_sum")[Library Checker · Dynamic Tree Vertex Add Path Sum]
