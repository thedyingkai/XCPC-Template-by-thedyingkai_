#import "叉积与点积各自保留什么信息/index.typ" as section-0
#import "atan、atan2、asin、acos 的输入与值域/index.typ" as section-1
#import "用 atan2(cross,dot) 求四种不同的夹角/index.typ" as section-2
#import "角度归一化、圆周接缝与零向量/index.typ" as section-3

#let render(code) = [
#heading(level: 2, outlined: true)[点线基础与夹角计算] <book-point-line>

整数点的 `dot/cross/square` 用 `i128`，交点、单位向量与距离用 `d128`。`pointOnLineLeft(p,l)` 判断有向 `a->b` 的严格左侧。

- `lineIntersection`：两线须不平行。
- `normalize`、`distancePL`：方向须非零。
- `distancePS`：允许线段退化为点。
- `pointOnSegment`：整数用精确判定，浮点用误差。

整数坐标差先在原类型 T 中相减，因此差也须装入 T；叉积、平方和须装入 `i128`。浮点符号用绝对误差 `GEOM_EPS`，排序按原坐标严格比较，坐标尺度改变时重新评估误差。

只比远近用距离平方；只判线段相交用叉积，避免先求浮点交点再反判。

#code("计算几何/点线基础与夹角计算/点与直线基础.cpp", mode: "full")

#metadata("功能入口") <geom-angles>


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

]
