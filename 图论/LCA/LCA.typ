固定一棵有根树后，`lca(u,v)` 是同时为 `u,v` 祖先且深度最大的点。它把一条树上路径拆成 `u -> lca` 与 `lca -> v` 两段，因此距离、路径第 $k$ 个点、树上差分和换根询问都会先落到 LCA。

倍增预存每个点向上 $2^j$ 级的祖先；先把两点提到同一深度，再从大到小尝试同时上跳。若某一级祖先不同，就说明 LCA 还在更高处而两点可以安全跳上去，最后两点父亲即为答案。树链剖分则不断把链顶更深的一端跳到上一条链，直到同链。欧拉序 RMQ 利用“两个点首次出现位置之间深度最小的点就是 LCA”。Tarjan 离线算法在 DFS 回溯时合并已经完成的子树，查询另一端所在并查集当前对应的祖先。

==== 选型

#table(
  columns: (auto, auto, auto),
  align: center,
  table.header([算法], [复杂度], [选用]),
  [倍增], [$O((n + m) log n)$], [普通在线询问；容易补向上跳 $k$ 级祖先],
  [Tarjan], [$O(n + m)$], [询问全部给出，只离线回答一次],
  [树链剖分], [$O(n + m log n)$], [还要做路径、子树操作],
  [RMQ + 欧拉序], [预处理 $O(n log n)$，查询 $O(1)$], [静态树、询问多],
)

四份实现都只预处理指定根所在的树。倍增、树链剖分和 Tarjan 已使用显式栈，链形树不会因 DFS 深度爆栈；RMQ 版先用 `addedge` 建树，再调用 `build(root)`。Tarjan 必须把 `(另一端, id)` 同时放进两端的查询表，编号使用 `1..m`，答案在 `ans[id]`；它只适合询问全部预先给出的离线场景。

倍增版还提供 `jump(u,k)`。令 `w=lca(u,v)`、`a=dep[u]-dep[w]`、`b=dep[v]-dep[w]`，从 `u` 起第 `k` 个点在上半段时为 `jump(u,k)`，否则为 `jump(v,a+b-k)`。边带权距离把深度换成根距离。换根为 `r` 后的 LCA，是原根下 `lca(u,v)`、`lca(u,r)`、`lca(v,r)` 中深度最大的一个。

#link("https://judge.yosupo.jp/problem/lca")[Library Checker · Lowest Common Ancestor]
