#let render(code) = [
#heading(level: 2, outlined: true)[有序集合、排名与前后驱（FHQ Treap）] <book-treap>

可重有序集合，支持插删、排名、第 $k$ 小、严格前后驱。操作期望 $O(log n)$；累计插入 $I$ 次占 $O(I)$ 空间，删除不回收节点。

- `erase(x)` 只删一个；`rank(x)` 返回严格小于 `x` 的数量加一，`x` 无需存在。
- `kth(k)` 从 1 计数；`kth/predecessor/successor` 无答案时返回 `nullopt`。
- 重复值各占一个节点；前驱严格小于，后继严格大于。

*分裂边界*　`splitLess(root,x,a,b)` 分成 `<x` 与 `>=x`；`splitLE` 分成 `<=x` 与 `>x`。`merge(a,b)` 要求 `max(a)<=min(b)`。这些操作修改原树，使用完须按值序合回并更新根。

值域 `[l,r]` 先按 `<l` 分裂，再对右半按 `<=r` 分裂。数量也可用 `countLE(r)-countLess(l)`；严格比较无需计算 `l-1`、`r+1`，避免极值溢出。区间权值和需增加聚合字段。

*改为序列树*　按大小分出前 `k` 项，区间 `[l,r]` 依次分出 `l-1`、`r-l+1` 项；中段打标记后合回。分裂、合并前下传标记。翻转交换左右儿子，有方向的聚合同时交换正反答案。

*压缩重复值*　每种值一个节点时加 `cnt`，子树大小包含 `cnt`，根占排名 `s+1..s+cnt`；删除先减 `cnt`，归零才移除。持久化需复制分裂、合并路径上的节点。

题目：P3369、P6136；#link("https://judge.yosupo.jp/problem/predecessor_problem")[Predecessor Problem]。

#code("数据结构与区间查询/有序集合、排名与前后驱（FHQ Treap）/FHQ Treap.cpp")


]
