#let render(code) = [
#heading(level: 3, outlined: true)[全点对：Floyd] <book-floyd>

小图全源最短路，允许负边，时间 $O(n^3)$、空间 $O(n^2)$。`add_edge(u,v,w)` 加有向边并保留重边最小值，无向边加两次；全部建边后 `run()`。

`query(u,v)==INF` 表示不可达；`path(u,v)` 返回顶点序列，不可达或相关负环导致无有限答案时返回空。`has_negative_cycle()` 判断是否存在 `dist[i][i]<0`；仅当源能到负环、负环能到汇时，该点对距离为负无穷。

*转移*　`k` 必须最外层，执行 `dist[i][j]=min(dist[i][j],dist[i][k]+dist[k][j])`，只从可达两段转移，并同步保存下一点。

`INF=LLONG_MAX/4`，边权与有限最短距离须在 `(-INF,INF)` 内。负环导致的更小值饱和到 `-INF`，仅用于判定，不作精确距离。

传递闭包把加法、取最小改成与、或；最小瓶颈路把路径拼接改成 `max`。按时间开放顶点时按开放顺序枚举中间点，答询问前还须检查两端已开放。

#code("图论/最短路径/全点对：Floyd/Floyd.cpp")


]
