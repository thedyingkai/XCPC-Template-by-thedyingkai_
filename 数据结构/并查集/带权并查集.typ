带权并查集处理形如 `val[a]-val[b]=w` 的相对关系。它不保存每个点的绝对值，只维护点到父亲的差；沿父链相加即可得到点到根的差。两点在同一连通块时，分别求出它们到共同根的差，再相减即可得到两点之差。差值约束、奇偶关系、食物链和前缀和关系都属于这一模型。

`weight[x]=val[x]-val[p[x]]`。路径压缩前先递归求旧父亲的根，再执行 `weight[x]+=weight[oldParent]`，此时 `weight[x]` 就是 `val[x]-val[root]`。设压缩后 `da=weight[a]`、`db=weight[b]`，两棵树的根分别为 `ra,rb`。约束 `val[a]-val[b]=w` 下，若把 `rb` 接到 `ra`，必须令

`weight[rb] = da - db - w`，这正是 `val[rb]-val[ra]`。

若按大小合并时交换了两棵树，就同时交换 `a,b` 并令 `w=-w`，仍可套同一公式。查询同一连通块内的差直接返回 `weight[a]-weight[b]`。

- 当前代码维护加法差：`weight[x] = val[x] - val[p[x]]`，下标为 `0..n-1`。
- `query(a,b)` 在不连通时返回 `nullopt`。
- 两点已经连通时 `unite` 只返回 `false`，不会判矛盾；应先检查 `query(a,b) == w`。
- 改模 $M$ 关系时，每次运算规范到 $[0,M)$。
- 改成异或关系时，路径压缩和合并公式中的加减改为异或；交换 `a,b` 时保留 `w`，不再执行 `w=-w`。
- 区间和约束可把前缀和当节点，区间和就是两个前缀节点的差。

- 洛谷 P2024「食物链」：改成模 $3$ 关系。
- #link("https://judge.yosupo.jp/problem/unionfind_with_potential")[Library Checker · Unionfind with Potential]
