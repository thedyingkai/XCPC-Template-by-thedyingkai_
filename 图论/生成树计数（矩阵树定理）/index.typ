#let render(code) = [
#heading(level: 2, outlined: true)[生成树计数（矩阵树定理）] <book-matrix-tree>

求生成树的边权乘积之和，普通计数令每边权为 1。点号 `1..n`；平行边权累加，自环忽略，一点图返回 1。时间 $O(n^3)$，空间 $O(n^2)$。

先构造 `MatrixTree mt(n)`，无向边用 `addUndirected`，有向边用 `addDirected`；两类分别保存。计数默认模 `1000000007`，模板参数可改，*模数须为质数*。

#table(
 columns: (auto, 1fr),
 table.header([入口], [方向与拉普拉斯增量]),
 [`countUndirected(root)`], [无向边两对角各 `+w`，两交叉项各 `-w`；删除点任选],
 [`countInArborescence(root)`], [所有点走向根；边 `u->v` 令 `L[u][u]+=w,L[u][v]-=w`],
 [`countOutArborescence(root)`], [根能到所有点；边 `u->v` 令 `L[v][v]+=w,L[v][u]-=w`],
)

建好矩阵后删除根对应行、列，求余子式行列式。换行变号，某列无非零主元则模意义下答案为 0；方案数模质数为 0 不代表不存在，存在性另判连通或对应可达性。合数模、精确整数须替换消元。

*指定必选无向边*　先判必选边是否成环；无环则缩其连通块，对剩余边在缩点图计数，再乘必选边权乘积。缩成自环的其他边丢弃。

题目：#link("https://judge.yosupo.jp/problem/counting_spanning_tree_undirected")[无向生成树计数]、#link("https://judge.yosupo.jp/problem/counting_spanning_tree_directed")[有向生成树计数] 均用 `998244353`，后者调用外向树入口。

#code("图论/生成树计数（矩阵树定理）/矩阵树定理.cpp")

参见 #link(<book-linear-system>)[行列式与高斯消元的接口约定]。


]
