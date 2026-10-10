#let render(code) = [
#heading(level: 4, outlined: true, numbering: none)[恢复最小割]

先在同一对象上完整运行 `dinic()`，再调用 `mincutPartition(dinic)`。从源沿正残量边可达的点为源侧，返回数组 `vis[u]=1`；其余为汇侧。

只枚举保存的原边，从源侧指向汇侧的边就是本次割边，零容量残量反边不计。最小割可能多解，返回其中一组。

二分匹配网络中，同一可达划分给出最小点覆盖：左部不可达点加右部可达点。

#code("网络流/最小割与划分恢复/恢复最小割/求最小割的划分_2.cpp", mode: "full")


]
