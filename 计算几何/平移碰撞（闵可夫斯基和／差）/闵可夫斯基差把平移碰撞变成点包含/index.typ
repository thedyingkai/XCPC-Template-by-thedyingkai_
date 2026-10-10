#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[闵可夫斯基差把平移碰撞变成点包含] <geom-minkowski>
记 $Q+t$ 表示把整个 $Q$ 平移 $t$。闭区域发生接触或相交，当且仅当

$ P inter (Q+t)!=emptyset
  arrow.l.r.double exists p in P,q in Q: p=q+t
  arrow.l.r.double t in P-Q. $

其中 $P-Q={p-q : p in P,q in Q}=P+(-Q)$；这里的减号是所有点对的向量差，不是集合差“去掉 $Q$”。它描述全部可碰撞的平移向量，也叫配置空间障碍。

对凸多边形，$P-Q=op("conv")({p_i-q_j})$。因为任意凸组合之差可展开成顶点差的凸组合，反过来差集合本身凸，且包含每个顶点差。小规模可枚举全部点对差再求凸包，复杂度 $O(n m log(n m))$、空间 $O(n m)$，很适合当线性版的对拍基线。

移动圆盘与障碍碰撞时，把障碍膨胀一个圆盘也是同一原理。若只要求不发生正面积交叠，允许接触的平移可能落在差多边形边界；若连接触都禁止，边界也不可行。两个对象均为凸且有正面积时，正面积相交对应差多边形内部；线段、点等低维对象需重定义“内部”和测度。



]
