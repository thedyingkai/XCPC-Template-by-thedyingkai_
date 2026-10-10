#let render(code) = [
#heading(level: 3, outlined: true)[可撤销并查集] <book-variant-003>

维护临时加入的连通关系，适用于线段树分治和版本树 DFS。点号 `1..n`；按大小合并，查找与合并 $O(log n)$，每条历史记录的撤销 $O(1)$。

*调用顺序*　进入分支时记 `snap=snapshot()`，执行该分支的合并与查询，退出时 `rollback(snap)`。失败合并不入栈，必须按快照回滚，不能按合并调用次数撤销。

`find` 不压缩路径。成功合并记录被挂接的根及父根旧大小；增加块权、异或势能或矛盾计数时，也要记录并恢复旧值。

*版本题*　从旧版本向依赖它的新版本连边。DFS 进入版本时做该版本操作，遍历子版本后回滚；当前根到节点的路径就是生效修改。DFS 过深时改显式栈。

题目：#link("https://judge.yosupo.jp/problem/persistent_unionfind")[Persistent Unionfind]。

#code("数据结构与区间查询/连通关系维护（并查集）/可撤销并查集/可撤销并查集.cpp")


]
