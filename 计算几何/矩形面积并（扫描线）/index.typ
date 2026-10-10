#let render(code) = [
#heading(level: 2, outlined: true)[矩形面积并（扫描线）] <book-rectangle-union>

轴对齐矩形并集面积，扫描线加线段树，时间 $O(n log n)$，空间 $O(n)$。输入满足 `x1<x2,y1<y2`。

`RectUnion(n)` 后填 `b[0..2n-1]` 的事件和 `a[0..2n-1]` 的横坐标：下边覆盖 `+1`，上边 `-1`。按 y 扫描，树维护 x 轴实际线段的覆盖长度，条带面积为 `当前覆盖长度*下一高度差`。

离散叶子代表相邻坐标间的线段，长度用原坐标差。当前坐标、覆盖长度、面积为 `i64`；可能溢出时同步扩宽 `w`、`sum` 和乘法。

周长并还需维护覆盖段数、左右端覆盖状态，并处理同高度事件，不能仅替换面积累加式。

题目：#link("https://judge.yosupo.jp/problem/area_of_union_of_rectangles")[Area of Union of Rectangles]。

#code("计算几何/矩形面积并（扫描线）/扫描线求矩形面积并.cpp", mode: "full", ignore-main: false)


]
