#let render(code) = [
#heading(level: 2, outlined: true)[二变量逻辑约束（2-SAT）] <book-two-sat>

求二元布尔子句的可行赋值，时间、空间 $O(n+m)$，`m` 为蕴含边数。变量 `1..n`；`solve()` 成功后读取 `ans[1..n]`。

- `either(x,xv,y,yv)`：`(x=xv) or (y=yv)`。
- `imply(x,xv,y,yv)`：蕴含，并自动补逆否边。
- `force(x,xv)`：固定取值；`id(x,true)` 表示取真节点。
- 不能同时选：`either(x,false,y,false)`；相等：两个方向同值蕴含；不等：至少一真加至少一假。

子句 $a or b$ 连 $not a->b$ 与 $not b->a$。某变量真假节点同 SCC 即无解。当前 SCC 编号为逆拓扑序，赋值比较依赖这个方向；更换 SCC 实现须相应改比较。

一组至多选一个，两两约束为平方规模，大组可加前缀辅助变量线性编码。一般三元子句超出 2-SAT 模型。

题目：#link("https://judge.yosupo.jp/problem/two_sat")[Two SAT]。

#code("图论/二变量逻辑约束（2-SAT）/2-SAT.cpp")


]
