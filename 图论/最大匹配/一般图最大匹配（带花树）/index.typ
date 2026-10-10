#let render(code) = [
#heading(level: 3, outlined: true)[一般图最大匹配（带花树）] <book-blossom>

Edmonds Blossom 求无向一般图最大基数匹配，允许奇环。`GeneralMatching gm(n)` 点号 `1..n`，`add(u,v)` 加边，自环忽略；全部建好后 `maxMatching()` 返回匹配边数。

`mate[u]==0` 为未匹配，输出 `u<mate[u]` 的边恢复方案。每次调用从空匹配重算。完美匹配要求有效点数为偶数且匹配数为其一半。

简单图或重边去重后时间 $O(n^3)$，空间 $O(n+m)$；大量重复边会增加扫描，建图前可去重。确定为二分图时用 Hopcroft–Karp。

*缩花要点*　交替树队列扩展偶层外点；两个外点相连产生奇环，沿 `p/mate` 找交替树公共祖先作为花基。`base` 表示收缩后的点，`markPath` 修复回溯父亲，最终沿 `p` 翻转即可恢复增广。这里的公共祖先属于当前搜索树，花中还可套花。

当前无权，最大权匹配须换相应算法。删除点后重建时，完美匹配目标按剩余点数计算。

题目：#link("https://judge.yosupo.jp/problem/general_matching")[General Matching]。

#code("图论/最大匹配/一般图最大匹配（带花树）/一般图最大匹配.cpp")


]
