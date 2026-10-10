#import "什么信息可以压缩到凸包/index.typ" as section-0
#import "支撑点与旋转卡壳的单调性/index.typ" as section-1
#import "O(log n) 凸多边形点定位/index.typ" as section-2
#import "接近最优结构时，把整体修改变成最小损失/index.typ" as section-3

#let render(code) = [
#heading(level: 2, outlined: true)[凸包极值与点定位（旋转卡壳）] <book-convex-hull>

`convexHull(points,false)` 排序去重，返回不重复首点的逆时针凸包，删除边上共线中点；传 `true` 保留共线点，全共线时返回排序后的全部点。时间 $O(n log n)$，空间 $O(n)$。

`diameter2(hull)` 求最远点对距离平方，输入须为凸包环序、相邻点互异、不重复首点。可直接接上述两种凸包输出；内部线性清理共线点，空集、单点返回 0，全共线取两端。时间与额外空间 $O(n)$，整数结果为 `i128`。

*卡壳更新*　边依次转动，对踵点按三角形面积单向推进；比较当前边两端与对踵点的距离。需要端点时同步记录，需原编号则在去重和删共线时保留映射。

只比直径保留平方，最终需要长度再开方。整数点差仍先在坐标类型内计算；浮点排序使用严格原值比较。

*改题*　最小宽度沿各边取最远面积除边长，再取最小；最小外接矩形需另维护投影极值。最近点对可能在内部，不可先删到凸包。

题目：#link("https://judge.yosupo.jp/problem/static_convex_hull")[Static Convex Hull]。

#code("计算几何/凸包极值与点定位（旋转卡壳）/凸包与旋转卡壳.cpp", parts: ("convex-hull", "diameter"))

#metadata("功能入口") <geom-convex>


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

]
