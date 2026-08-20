FHQ Treap 同时满足二叉搜索树的值序与随机优先级的堆序，通过 `split/merge` 维持期望 $O(log n)$ 高度。当前是可重有序集合，支持插入、删除一个值、排名、第 $k$ 小、严格前驱和严格后继；若把分裂条件改成左侧元素个数，就得到维护序列的隐式 Treap。

==== split 与 merge

`splitLess(root,x,a,b)` 保证 `a` 中所有值严格小于 `x`、`b` 中所有值不小于 `x`；`splitLE` 则分成 `<=x` 与 `>x`。`merge(a,b)` 的前提是 `a` 的每个值都不大于 `b` 的每个值，它只按随机优先级决定新根，不能拿两棵值域交错的树直接合并。插入先按 `<x` 分开再把新点夹在中间；删除用两次分裂隔离所有等于 `x` 的节点，合并该子树根的左右儿子只删掉其中一个。

- 重复值各占一个节点，`erase(x)` 只删一个；`rank(x)` 为“小于 `x` 的数量加一”。
- `kth`、`predecessor`、`successor` 无答案时返回 `nullopt`；节点不回收，空间按插入总数预留。

- 文艺平衡树把 `split` 改为按子树大小分裂，再加懒标记和 `pushdown`。
- 每个值只建一个节点时增加 `cnt`；可持久化时复制 `split/merge` 沿途节点。
- 取值域 `[l,r]`：先按 `<l` 分裂，再对右半棵按 `<=r` 分裂。
- 前驱严格小于、后继严格大于；题目边界不同要同步修改比较符号。

- 洛谷 P3369「普通平衡树」；P6136 用于检查重复值和强制在线。
- #link("https://judge.yosupo.jp/problem/predecessor_problem")[Library Checker · Predecessor Problem]
