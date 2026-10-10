#import "树上异或路径不用 LCA/index.typ" as section-0
#import "换根后的子树只分三种情况/index.typ" as section-1
#import "路径顺序敏感：左右两端分别收集/index.typ" as section-2

#let render(code) = [
#heading(level: 2, outlined: true)[路径与子树查询（树链剖分）] <book-hld>

将固定树路径拆为 $O(log n)$ 个 DFS 序闭区间，接线段树后路径操作 $O(log^2 n)$，子树操作 $O(log n)$。预处理先重儿子后轻儿子，重链和子树各自连续，使用显式栈。

`path(u,v,f)` 对每段调用 `f(l,r)`，默认含两端。边权放在较深端点，传 `edge=true` 排除 LCA；`subtree(u,true)` 可能为空，使用前检查 `l<=r`。

*路径方向*　当前回调不保留全路径顺序。和、最大值可直接合并；矩阵乘、哈希须分别积累 `u`、`v` 两侧，并处理段内翻转。路径上找首个满足条件的位置，还需区间结构支持定向下降。

*换根子树*　新根为 `r`：`u==r` 取全树；`u` 不是 `r` 的原祖先则取原子树；否则找 `u` 朝 `r` 的儿子 `c`，取全树扣除 `c` 子树，可拆成两段区间。

题目：#link("https://judge.yosupo.jp/problem/vertex_add_path_sum")[Vertex Add Path Sum]。

#code("树上问题/路径与子树查询（树链剖分）/树链剖分.cpp")

*换根*　当前根为 `r`，查询 `u` 子树：`u==r` 取全树；`u` 非 `r` 祖先取原子树；否则令 `c=jump(r,dep[r]-dep[u]-1)`，取全树减 `c` 子树。


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

]
