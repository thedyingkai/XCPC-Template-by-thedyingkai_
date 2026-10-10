#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("图上高低度分治")] <trick-misc-26>
*问题概述*　#text("给定 ")$n$#text(" 点 ")$m$#text(" 边简单无向图及节点初值，支持 add(v,d)：给 ")$v$#text(" 的所有邻居加整数 ")$d$#text("，但不改 ")$v$#text(" 自身；支持 query(u)：返回 ")$u$#text(" 当前值。图结构静态，无自环或重复边，要求利用高低度避免每次遍历高点全部邻居。")

*必要思路*　#text("度")$≤B$#text(" 的修改直接遍历；度>B 的点只更新懒标记。单点查询加上相邻高点标记；高点")$≤2m/B$#text(" 个，预处理高点邻接关系。复杂度约修改 ")$O(B)$#text("、查询 ")$O(m/B)$#text("，还需计算存储和预处理成本。自行推导。")

*实现提示*　#text("简单无向图中给邻居加值、查询单点。")$op("heavyNeighbors")_(u)$#text(" 预先存 ")$u$#text(" 的高点邻居；base 初始化为原值。更新 ")$O(B)$#text("，查询 ")$O(m/B)$#text("，总预处理 ")$O(n+m)$#text("。")

*伪代码*（需结合题目接口实现）

#trick-code("heavy[v] = (degree[v] > B)\nfor every edge (u,v):\n  if heavy[u]: heavyNeighbors[v].push(u)\n  if heavy[v]: heavyNeighbors[u].push(v)\nlazy[all] = 0\nadd_to_neighbors(v, delta):\n  if heavy[v]: lazy[v] += delta\n  else:\n    for u in adj[v]: base[u] += delta\nquery(u):\n  result = base[u]\n  for v in heavyNeighbors[u]: result += lazy[v]\n  return result")

*依据*　自行推导/归纳，理由已写在思路中。


参见 #link(<trick-misc-25>)[一般高低频分治的复杂度推导]。

#pagebreak()


]
