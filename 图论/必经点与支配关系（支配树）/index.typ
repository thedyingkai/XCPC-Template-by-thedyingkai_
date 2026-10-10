#let render(code) = [
#heading(level: 2, outlined: true)[必经点与支配关系（支配树）] <book-dominator>

固定有向图源点 `s`，若所有 `s->v` 路径都经过 `u`，则 `u` 支配 `v`。适用于单点删除后的可达性与必经点；原图允许环。

`DominatorTree dt(n)` 使用 `1..n`，逐条 `add(u,v)`，再 `build(s)`。返回 `idom`：根为 0，不可达点为 −1；`tree` 保存支配树。`dominates(u,v)` 为树上祖先判断，含 `u==v`，单次 $O(1)$。换源须重建。

*查询转换*　对原本可达的 `v`，删除 `u` 后仍可达等价于 `!dominates(u,v)`，端点是否计入按题意处理。受 `u` 阻断的点为其支配树子树；排除 `u` 自身则减一。必经点是源到 `v` 的支配树链，多个点同时删除不能仅套单点判断。

必经边可拆成边点后求支配，规模变为 $O(n+m)$；固定终点 `t` 时反向建图、以 `t` 为源；多起点任选其一时加超级源，得到的是所有这些路径共同的支配关系。

*实现要点*　Lengauer–Tarjan 倒序求半支配点，`eval` 维护 DFS 祖先段上的最小半支配序；并查集连接须遵循 DFS 父子关系。最后正序修正 `dom[w]=dom[dom[w]]`，得到立即支配点。当前简化版时间 $O((n+m)log n)$、空间 $O(n+m)$，遍历用显式栈。

题目：#link("https://judge.yosupo.jp/problem/dominatortree")[Dominator Tree] 要求源项输出 `s`，须将当前根的 0 改为 `s`。

#code("图论/必经点与支配关系（支配树）/支配树.cpp")


]
