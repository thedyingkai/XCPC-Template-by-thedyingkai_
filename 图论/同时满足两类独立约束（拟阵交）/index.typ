#import "增广框架/index.typ" as section-0
#import "划分拟阵与图拟阵/index.typ" as section-1

#let render(code) = [
#heading(level: 2, outlined: true)[同时满足两类独立约束（拟阵交）] <book-matroid>

同一地面集上的两套拟阵约束，求公共独立集的最大元素数。典型为彩虹森林：颜色不重复且所选边无环，选满 `vertices-1` 条即彩虹生成树。当前求无权最大基数。

*接口*　候选元素编号 `0..n-1`，两判定器的元素顺序完全一致：`reset(chosen)` 重建当前集合，`canAdd(in)` 判加入，`canExchange(out,in)` 判删一加一。每轮查询均相对固定集合，判定不能永久改状态。

彩虹森林按相同顺序准备 `edges`、`group`，构造 `PartitionMatroidOracle first(group,vector<int>(颜色数,1))`、`GraphicMatroidOracle second(vertices,edges)`，调用 `matroidIntersection(边数,first,second)`；返回所选元素编号。图点号 `1..vertices`，稀疏大编号先离散化。

*交换图方向*　`x` 已选、`y` 未选：第一拟阵允许 `I-x+y` 则连 `x->y`，第二拟阵允许则连 `y->x`。第一拟阵可直接加的元素为起点，第二拟阵可直接加的为终点。多源 BFS 取最短增广路，沿路翻转，大小增加一；任意 DFS 路径不保证合法。

*常用判定器*

- 划分拟阵：每组数量不超过 `capacity[group]`。
- 图拟阵：所选边构成森林。新边两端不连通可直接加；已连通则交换掉唯一路径上的边。删边朝向子端点后，用“两端恰有一个在其子树”判交换。自环不可选，平行边分别作为候选。
- 两边都是容量 0/1 的划分拟阵：调用 `unitPartitionMatroidIntersection(first,second)`。设组数合计 `g`，时间 $O((n+g)sqrt(g))$，空间 $O(n+g)$。

通用版本答案大小为 $r$，单次判定 $C$、每轮重建 $R$ 时，时间 $O((r+1)(n^2 C+R))$；框架额外空间 $O(n)$ 加判定器状态。

每套约束须满足遗传性与增广性：独立集 `A,B` 且 `|A|<|B|` 时，存在 `B-A` 元素可加入 `A`。一般图匹配、任意背包容量不满足；最大权与三套约束需其他算法。

题目：#link("https://www.spoj.com/problems/COIN/")[SPOJ COIN] 将每轮信封设为容量 1 的颜色组、硬币对设为图边，答案为所选边数的两倍。


#section-0.render(code)

#section-1.render(code)

]
