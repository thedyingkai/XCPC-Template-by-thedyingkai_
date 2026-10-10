#import "经过全部关键点：剪叶子得到最小连通子树/index.typ" as section-0
#import "关键点按 DFS 序成环：边被算两次/index.typ" as section-1
#import "虚树：只补相邻关键点的 LCA/index.typ" as section-2
#import "虚树边贡献：结构点不是计数对象/index.typ" as section-3

#let render(code) = [
#heading(level: 2, outlined: true)[少量关键点构树（虚树）] <book-virtual-tree>

每次只有 $k$ 个关键点时，保留关键点与必要 LCA，将树上 DP 压到 $O(k)$。删掉的原链须能由距离、最小边权或可复合转移概括。

*调用*　原图建立 `HLD hld(n,root,g)`，再 `VirtualTree vt(n,hld)`。每次 `r=vt.build(key)`，空集返回 0；`nodes` 包含关键点和补入 LCA，`g` 只存父到子边。原邻接表、HLD 在整个查询期间须存活。

`nodes` 按 DFS 序排，父亲在儿子前，逆序可做子树 DP。构造仅清理上次邻接表；关键标记、次数、DP 由调用方按本次 `nodes` 清理。结构会去重关键点，重复对象另存次数。

*规模与边权*　关键点按 DFS 序排序，补相邻 LCA，再栈建树；不同关键点 $k>0$ 时至多 `2*k-1` 点。构造 $O(k log k+k log n)$，临时 $O(k)$，常驻邻接表 $O(n)$。当前虚边存 `int` 深度差；加权距离改为 `rootDist[v]-rootDist[u]` 并扩类型，链上最小边权另用路径查询。

*距离统计*　子树关键对象数 `cnt[v]`，总数 `k`，边长 `w`：无序点对距离贡献 `w*cnt[v]*(k-cnt[v])`，有序点对乘二。乘法先扩宽。非负边下，连接全部关键点的最小子树长度为满足 `0<cnt[v]<k` 的虚边长度和。

*割断根与关键点*　删除代价非负，根非关键点。将固定根加入结构，虚边权改成原链最小边权；儿子 `v` 为关键点则贡献该边权，否则贡献 `min(边权,dp[v])`，各儿子相加。加入结构的根无需自动标成关键对象。

#code("树上问题/少量关键点构树（虚树）/虚树.cpp")


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

]
