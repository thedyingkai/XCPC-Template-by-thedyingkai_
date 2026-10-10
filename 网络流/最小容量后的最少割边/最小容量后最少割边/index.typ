#let render(code) = [
#heading(level: 4, outlined: true, numbering: none)[最小容量后最少割边]

原图有 `m` 条有向原边，取 `base=m+1`，编码容量为 `c*base+1`。割边数至多 `m`，因此先最小化原容量，再最小化边数。

`mincutEdgeCountResult(n,S,T,edges)` 返回 `{capacity,edgeCount}`，`mincutEdgeCount` 仅返回边数。平行原边分别计数，自动残量反边不计入 `m`。

单边编码用 `i128` 检查后存入 `i64`，编码后的总最大流也须装入 `i64`。若次级代价改为边代价 `d`，用 `c*base+d`，并让 `base` 严格大于任意割的次级代价总和。

#code("网络流/最小容量后的最少割边/最小容量后最少割边/求最小割的最少边数_3.cpp", mode: "full")


]
