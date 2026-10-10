#let render(code) = [
#heading(level: 3, outlined: true)[带权并查集] <book-variant-002>

维护约束 `val[a]-val[b]=w`，适用于差值、前缀和与模关系。点号 `0..n-1`；单次操作均摊 $O(alpha(n))$，空间 $O(n)$。

*调用与判矛盾*　`query(a,b)` 返回两点之差，不连通时返回 `nullopt`。已连通时先检查查询值是否等于 `w`；`unite(a,b,w)` 遇到同根只返回 `false`，不会自动判矛盾。

*符号约定*　`weight[x]=val[x]-val[p[x]]`。压缩时先处理旧父亲，再累加它到根的权。设压缩后的差为 `da,db`，将 `rb` 接到 `ra` 下应写 `weight[rb]=da-db-w`。

按大小合并若交换 `a,b`，同时令 `w=-w`；同根查询为 `weight[a]-weight[b]`。差值及累加结果须装入权值类型。

*改法*　模 $M$ 关系把每次运算规范到 $[0,M)$；异或关系把加减换成异或，交换两点时保留 `w`。区间和 $[l,r]$ 建成前缀节点约束 `val[r]-val[l-1]=w`。

题目：洛谷 P2024（模 3）；#link("https://judge.yosupo.jp/problem/unionfind_with_potential")[Unionfind with Potential]。

#code("数据结构与区间查询/连通关系维护（并查集）/带权并查集/带权并查集.cpp")


]
