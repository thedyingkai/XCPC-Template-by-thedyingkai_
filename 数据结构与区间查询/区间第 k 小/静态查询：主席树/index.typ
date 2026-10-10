#let render(code) = [
#heading(level: 3, outlined: true)[静态查询：主席树] <book-persistent-kth>

静态区间第 $k$ 小与值域计数。`ChairmanTree(a)` 要求 `a[0]` 占位、实际数据在 `a[1..n]`。不同值数为 $V$ 时，建树与空间 $O(n log V)$，查询 $O(log V)$。

- `kth(l,r,k)`：位置、排名均从 1 开始，要求 `1<=k<=r-l+1`，返回原值。
- `count(l,r,low,high)`：位置 `[l,r]`、值域 `[low,high]` 都闭合；值域端点不必在数组中出现。

*版本差*　`root[i]` 记录前 `i` 项频次；区间使用 `root[r]-root[l-1]`。下降时左侧计数为两个左儿子的和之差；`k` 超过它则扣去该数并走右。路径复制只改新节点，旧节点及共享子树保持不变，0 号节点代表全零树。

*常用改法*

- 第 $k$ 大改查第 `r-l+2-k` 小。前 $k$ 小之和需增加权值和：向右前累加左侧和，叶子处加入剩余 `k*原值`。
- 树上路径：`root[v]` 从父亲版本插入点权，查询同时组合 `root[u]+root[v]-root[lca]-root[parent[lca]]`；根的父版本为空。
- 严格小于 `x` 用 `lower_bound(x)` 定边界，避免 `x-1` 溢出。区间最大值不具备版本相减关系。

按数量下降要求组合后的每段频次非负；任取无包含关系的历史版本相减不保证这一点。带修改的区间排名需树状数组套权值树等结构。

题目：P3834、P2633；#link("https://judge.yosupo.jp/problem/range_kth_smallest")[Range Kth Smallest]。

#code("数据结构与区间查询/区间第 k 小/静态查询：主席树/主席树.cpp")


]
