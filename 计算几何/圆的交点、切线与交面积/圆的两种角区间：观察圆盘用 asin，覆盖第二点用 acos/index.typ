#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[圆的两种角区间：观察圆盘用 asin，覆盖第二点用 acos] <geom-circle-angle>
*从圆外观察圆盘。* 观察点为 $A$，圆心为 $O$，半径为 $r>0$，距离 $d=|A O|>r$。两条边界射线是从 $A$ 作的切线。切点 $T$ 满足 $O T perp A T$，在直角三角形 $A O T$ 中，

$ sin alpha=r/d, quad alpha=op("asin")(r/d). $

区间中心是 $O-A$ 的方向，半宽为 $alpha$。相切是否算命中决定区间开闭。$d<r$ 时观察点在圆盘内部；$d=r$ 时必须区分是否把起点 $t=0$ 的接触算作命中：若算，则所有方向在起点已命中；若只算正参数处的接触，只有指向圆盘内部的方向有效。半径零另作点对象处理。

*固定半径圆经过 $A$，还要覆盖 $B$。* 圆心 $C=A+R(cos theta,sin theta)$，$R>0$，令 $d=|A B|>0$、$phi$ 为 $B-A$ 的方向。展开 $|C-B|^2<=R^2$：

$ R^2+d^2-2R d cos(theta-phi)<=R^2
  arrow.r cos(theta-phi)>=d/(2R). $

所以 $0<d<=2R$ 时圆心方向区间半宽为 $alpha=op("acos")(d/(2R))$。$d>2R$ 无解，$d=0$ 不限制圆心方向，$d=2R$ 只剩一个方向；若要求严格覆盖，等号端点须排除。$R=0$ 时只能覆盖与 $A$ 重合的点。

这两个比值来自不同的三角形。先判断几何对象存在，再对舍入导致的轻微越界使用 `clamp(t,-1.0L,1.0L)`。把本来无交点的圆硬夹进合法范围，会制造错误的“切点”或“交点”。



]
