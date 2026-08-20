Euler Tour Tree 把一棵树的欧拉游走序列放进隐式 Treap，适合动态森林中的加边、删边、连通性和整棵连通块聚合。`link/cut` 修改森林，`setValue` 改点权，`componentSum/componentSize` 读取当前连通块；若题目问路径而不是整块，应优先改用 Link-Cut Tree。

每个点有一个计入聚合的自标记，每条树边增加两个只负责连接序列的有向标记；`cut(u,v)` 只能删除此前直接加入的边。被删边的 Treap 节点不回收，空间按操作总数估算。

- 当前聚合为点权和与点数。维护其他可交换连通块信息时同步修改节点聚合；路径信息不能从这份欧拉游走序列直接得到。
- 结构仅维护森林；一般动态图需把非树边另外保存，并在删树边后寻找替代边。

- 询问边 `(v,p)` 下以 `p` 为父亲的 `v` 子树时，临时 `cut(v,p)`，读取 `componentSum(v)` 后再 `link(v,p)`。
- #link("https://judge.yosupo.jp/problem/dynamic_tree_vertex_add_subtree_sum")[Library Checker · Dynamic Tree Vertex Add Subtree Sum]
