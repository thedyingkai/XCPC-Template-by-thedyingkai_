==== 四种 LCA 求法
#table(
  columns: (auto, auto, auto, auto),
  align: center,
  table.header(
    [倍增算法],
    [Tarjan算法],
    [树链剖分],
    [RMQ+欧拉序],
  ),
  [
    倍增法 \
    深搜打表，跳跃查询
  ],
  [
    并查集 \
    深搜，回时指父，离时搜根
  ],
  [
    重链剖分 \
    两遍深搜打表，跳跃查询
  ],
  [
    DFS 获欧拉序与深度 \
    构建 ST 表（RMQ），查询区间深度最小节点
  ],
  [ $O((n + m) log n)$ ],
  [ $O(n + m)$ ],
  [ $O(n + m log n)$ ],
  [ 预处理 $O(n log n)$ ，查询 $O(1)$  ],
)
