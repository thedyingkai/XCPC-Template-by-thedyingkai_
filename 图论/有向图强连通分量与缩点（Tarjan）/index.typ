#let render(code) = [
#heading(level: 2, outlined: true)[有向图强连通分量与缩点（Tarjan）] <book-scc>

有向图按 SCC 缩成 DAG；无向图按桥缩成边双森林，按点双与割点建圆方森林。点号 `1..n`，非连通图须遍历全部未访问起点。

*Tarjan 判定*　`dfn` 为首次访问序，`low` 为 DFS 可回到的最早位置。树边 `u-v`：

- `low[v]>dfn[u]`：该边是桥。
- `low[v]>=dfn[u]`：形成点双边界，非根 `u` 是割点。
- DFS 根有至少两个 DFS 儿子才是割点。

无向图按边编号跳过父边的反向边，保留平行回边。SCC 只从仍在 Tarjan 栈中的点更新 `low`。割点可属于多个点双，点双归属用集合保存。

接 LCA 时，桥森林、圆方森林先判同树；不同树之间没有路径。

将有向图互相可达的点缩为 SCC，结果为 DAG。`work()` 后读取 `scc[u]`、分量数 `cnt`、大小 `sz[id]`。显式 DFS 栈，主过程时间、空间 $O(n+m)$。

当前编号按逆拓扑序产生，缩点边从大编号指向小编号。`shrink()` 排序去重出边，最坏 $O(n+m log m)$；若重边表示不同方案，须按题意保留重数。

*low 更新*　DFS 树边返回时用子节点 `low`；遇已访问边，仅当目标仍在 Tarjan 栈中才用其 `dfn`。`low[u]==dfn[u]` 时弹栈至 `u`，得到一个 SCC。

缩点 DP 先按 `scc[u]` 合并点权，再按拓扑依赖处理。补成强连通图：已有一个 SCC 时为 0，否则为 `max(零入度分量数,零出度分量数)`。

题目：#link("https://judge.yosupo.jp/problem/scc")[Strongly Connected Components]。

#code("图论/有向图强连通分量与缩点（Tarjan）/Tarjan SCC 缩点.cpp")


]
