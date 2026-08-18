==== 用途

- 输入布尔变量和若干个至多含两个文字的限制，判断是否存在同时满足全部限制的取值，并返回一组可行赋值。
- 互斥、二选一、蕴含和固定取值都可转成蕴含图；最终由强连通分量判断矛盾并确定取值。

==== 接口

- `id(x, true)` 表示变量 `x` 为真；`either(x, xv, y, yv)` 加入 `(x=xv) or (y=yv)`。
- `imply(x, xv, y, yv)` 加入蕴含并自动补逆否边；`force(x, xv)` 固定取值。
- `solve()` 返回是否有解，成功后赋值在 `ans[1..n]`。
- 赋值依赖当前 Tarjan 的逆拓扑编号；更换 SCC 实现后必须检查大小比较方向。

==== 常用限制

- 不能同时为真：`either(x, false, y, false)`。
- `x == y`：`imply(x, true, y, true)`、`imply(y, true, x, true)`。
- `x != y`：`either(x, true, y, true)`、`either(x, false, y, false)`。
- 多个变量至多一个为真时，两两连边是平方级；数据大时用前缀辅助变量优化。

- 洛谷 P4782「2-SAT」。
