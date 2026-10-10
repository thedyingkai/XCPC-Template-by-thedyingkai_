#let render(code) = [
#heading(level: 2, outlined: true)[上下界可行流] <book-bounded-flow>

边流量限制 `lower<=f<=upper`，其中 `0<=lower<=upper`。`LowerBoundFlow(n)` 原点 `1..n`，内部占 `n+1,n+2`；`add(u,v,lower,upper)` 返回原边编号。

*入口只选一个*

- 无源汇循环流：`feasible()`。
- 非负源汇可行流：`feasible(s,t)`，额外连 `t->s` 大容量边。
- 非负源汇最大流：直接 `maxFlow(s,t)`，失败为 `nullopt`；它内部已调用可行性检查。

原边全部加完后求解，`feasible` 只能调用一次。成功后 `edgeFlow(id)` 恢复原边流量。当前源汇入口只覆盖净流量非负的模型。

*辅助边方向*　原边先扣下界，只保留容量 `upper-lower`，记 `balance=下界流入-下界流出`。正 balance 连 `SS->u`，负 balance 连 `u->TT`。超级源满流即有解。原边实际流量为下界加其反残量。

*后续增广*　保存回边 `t->s` 的流量 `returnFlow`，清空所有辅助边的正反容量，保留原边反容量。再从 `s` 到 `t` 增广，所得新增流加基础流即最大值。

*恰好 k*　自行加入 `t->s`、上下界均为 `k>=0`，然后调用无参数 `feasible()`。

*最小非负流*　先 `feasible(s,t)`，保存基础流并清空辅助正反边，再从 `t` 到 `s` 退流，退流上限为基础流。当前没有此入口，需给 Dinic 增加总推流上限。

最多两次 Dinic，时间上界 $O(V^2E)$，空间 $O(V+E)$。回边上限为 `LLONG_MAX/4`，真实需求、balance、基础流与容量和须落在安全范围。带费用下界流还需处理可行阶段留下的残量负环，不能只给 Dinic 加费用字段。

#code("网络流/上下界可行流/有上下界可行流.cpp")

#pagebreak()


]
