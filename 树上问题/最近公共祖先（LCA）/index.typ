#import "倍增求 LCA/index.typ" as section-0
#import "Tarjan 离线求 LCA/index.typ" as section-1
#import "树链剖分求 LCA/index.typ" as section-2
#import "欧拉序与 RMQ 求 LCA/index.typ" as section-3

#let render(code) = [
#heading(level: 2, outlined: true)[最近公共祖先（LCA）] <book-lca>

固定根下两点的最近公共祖先。只预处理指定根所在的树；森林查询先判同树。

#table(
 columns: (auto, 1fr, 1fr),
 table.header([实现], [预处理／单次], [用途]),
 [倍增], [$O(n log n)$／$O(log n)$], [在线 LCA、上跳祖先],
 [Tarjan], [全体 $O((n+m)alpha(n))$], [所有询问预先给出],
 [树链剖分], [$O(n)$／$O(log n)$], [同时做路径、子树操作],
 [欧拉序 RMQ], [$O(n log n)$／$O(1)$], [静态大量查询],
)

Tarjan 将 `(另一端,id)` 同时加入两端查询表，`id=1..m`，答案在 `ans[id]`。RMQ 版先 `addedge` 再 `build(root)`。倍增、HLD、Tarjan 的遍历使用显式栈。

*路径第 k 点*　先将从 1 开始的点排名减一，得到边数 `k`。令 `w=lca(u,v)`，`a=dep[u]-dep[w]`，`b=dep[v]-dep[w]`，要求 `0<=k<=a+b`：`k<=a` 取 `jump(u,k)`，否则取 `jump(v,a+b-k)`。

带权距离为 `dist[u]+dist[v]-2*dist[w]`，上跳步数仍用深度差。换根为 `r` 的 LCA，是原根下 `lca(u,v),lca(u,r),lca(v,r)` 中深度最大者。

题目：#link("https://judge.yosupo.jp/problem/lca")[Lowest Common Ancestor]。


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

]
