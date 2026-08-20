矩阵树定理把“图中有多少棵生成树”转成一个 Laplacian 余子式的行列式。边权不是距离，而是选择这条边的方案权；因此结果是每棵树边权乘积之和，普通计数把全部权设为 `1`。平行边会自然累加，自环不会进入生成树。

无向边 `(u,v,w)` 给两个对角元各加 $w$，给两个非对角元各减 $w$。从 Laplacian 删除任意同编号的一行一列后，行列式展开中只有选出一棵生成树的项不会相互抵消，所以余子式就是加权生成树数。图不连通时余子式必为零。

有向图必须先看清方向：`countInArborescence(root)` 统计每个非根点选一条出边、最终都指向根的内向树，使用出度 Laplacian；`countOutArborescence(root)` 统计从根能到所有点的外向树，使用入度 Laplacian。两者颠倒是最常见的 WA，建议用两三个点的单向链手算核对。

点编号为 `1..n`。`countUndirected(root)` 中删除哪一个点不影响无向答案；三类接口都默认模 `1000000007`，可写成 `countUndirected<Mod>` 等改模数。当前行列式通过费马逆元消元，`Mod` 必须是质数；若题目要求合数模或精确整数，必须换成无除法消元或分解模数。复杂度为 $O(n^3)$，大规模稀疏图不能靠稀疏存边绕过行列式瓶颈。

Library Checker 的两题模数都是 `998244353`：无向题调用 `countUndirected<998244353>`；有向题要求根能到达所有点，必须调用 `countOutArborescence<998244353>(root)`。不能沿用默认的 `1000000007`，也不能把有向题写成统计指向根的 `countInArborescence`。

#link("https://judge.yosupo.jp/problem/counting_spanning_tree_undirected")[Library Checker · Counting Spanning Tree Undirected]

#link("https://judge.yosupo.jp/problem/counting_spanning_tree_directed")[Library Checker · Counting Spanning Tree Directed]
