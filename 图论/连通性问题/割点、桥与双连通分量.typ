四份板子处理无向图。`CutEdge` 枚举桥；`EDCC` 给每个点唯一的边双编号 `dcc[u]`；`CutDot` 同时给出割点 `cut[u]` 和每个点双的点集 `bcc`；`VDCC` 的对应点集保存在 `dcc`。四份 DFS 都已改成显式栈，链图不会因递归深度崩溃。

`CutEdge::add` 和 `EDCC::add` 每条无向边只调用一次，内部会加入正反边；`EDCC(n,m)` 中的 `m` 必须是实际无向边数。`CutDot`、`VDCC` 接受一份对称的无向邻接表，构造时按端点建立边编号，随后对每个未访问点调用 `tarjan(start)`。平行边会保留并正确阻止其成为桥，自环对割点、桥和通常的点双划分没有贡献；孤立点单独成为一个点双。

桥的判定是树边 `u-v` 满足 `low[v] > dfn[u]`。边双可在桥全部标出后，忽略桥做一次遍历；点双则在 `low[v] >= dfn[u]` 时，从边栈弹到树边 `u-v`，这些边的所有端点构成一个点双。用边栈而不是只用点栈，才能在平行边和多个回边下明确分量边界。

==== 如何继续做题

- 桥森林：把每个边双缩成点，所有桥连接不同缩点。两点之间必经桥数就是它们在桥森林上的距离。
- 圆方森林：每个点双新建一个方点，与分量内所有原点相连。割点会连接多个方点；删点连通性、路径必经割点可转成圆方树路径问题。
- 连通图加最少边变成边双连通图：桥树有 `leaf` 个叶子时答案为 `(leaf+1)/2`。原图不连通时不能直接套这个式子。
- 删除非根点后的连通块数由满足 `low[v] >= dfn[u]` 的 DFS 儿子数决定；根则只看 DFS 儿子数。端点是否也算“被断开”必须按题意另外处理。

#link("https://judge.yosupo.jp/problem/biconnected_components")[Library Checker · Biconnected Components]

#link("https://judge.yosupo.jp/problem/two_edge_connected_components")[Library Checker · Two-Edge-Connected Components]
