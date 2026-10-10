#let render(code) = [
#heading(level: 3, outlined: true)[二分图最大匹配] <book-bipartite-matching>

Hopcroft–Karp 求二分图最大基数匹配，时间 $O(E sqrt(V))$，空间 $O(V+E)$。分层搜索使用显式栈。

左部 `1..n`、右部 `1..m`，`add(u,v)` 加允许配对边。`maxMatching()` 返回当前匹配总数，`ml[u]/mr[v]` 给出对象，0 表示未匹配。枚举非零 `ml` 恢复方案；只新增边后可继续调用，删边后重建。

*最小点覆盖*　`minVertexCover()` 先补跑最大匹配，再从未匹配左点沿“左到右非匹配边、右到左匹配边”搜索。答案是左部未访问点与右部访问点，大小等于最大匹配。其补集为最大独立集。

*DAG 路径覆盖*　每点拆成左右副本，原边从左连右，最少不交路径数 `n-匹配数`。若相邻链元素只要求可达，先补传递闭包。点容量改最大流，带权配对改 KM 或费用流；一般图匹配另用带花树。

题目：#link("https://judge.yosupo.jp/problem/bipartitematching")[Bipartite Matching]。

#code("图论/最大匹配/二分图最大匹配/二分图最大匹配.cpp")


]
