#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("对象生存期转时间线段树")] <trick-misc-29>
*问题概述*　#text("给定空或指定初始无向图及完整离线时间序列，支持按唯一边 ID 加入、删除和两点连通性查询。每次有效加入持续到对应删除前，同一 ID 删除后可再加入；求各时刻答案，要求数据结构在 DFS 返回时能撤销本层修改。")

*必要思路*　#text("求每个对象活跃时间 [l,r)，挂到覆盖这段的时间线段树节点；DFS 入节点加对象，出节点回滚到快照。可回滚 DSU 常用按大小合并并禁路径压缩；一个对象生命周期要正确匹配重加入。")

*实现提示*　#text("先把每次有效加入匹配到下一次删除，生成 [l,r) 并挂到时间线段树。snapshot 记回滚栈长度；DSU 不路径压缩、按大小合并，记录被修改的父亲和大小。重复边需明确按 ID 或出现次数匹配。")

*伪代码*（需结合题目接口实现）

#trick-code("dfs(segment_node):\n  snapshot = history.size()\n  for edge (u,v) stored in this node:\n    unite_by_size(u,v)  // log each actual mutation\n  if this node represents one time t:\n    answer query at t from current DSU\n  else:\n    dfs(left_child); dfs(right_child)\n  while history.size() > snapshot:\n    undo last mutation\n// a lifetime occupies O(log Q) segment nodes\n// DSU find is O(log n) without path compression")

*参考*　#link("https://cp-algorithms.com/data_structures/deleting_in_log_n.html")[#text("CP-Algorithms：离线删除与回滚")]。


参见 #link(<book-dsu>)[可撤销并查集]。


]
