#import "圆的两种角区间：观察圆盘用 asin，覆盖第二点用 acos/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[圆的交点、切线与交面积] <book-circle>

圆半径非负，各接口常数时间。`circleRelation` 返回：0 相离、1 外切、2 两交点、3 内切、4 内含、5 重合。

- `lineCircleIntersection` 求无限直线交点；线段另用 `pointOnSegment` 过滤，直线方向须非零。
- `circleIntersection` 求两圆交点；重合时返回空，须先用关系值区分无交点、重合正半径的无穷交点与零半径同一点。
- `tangentPoints(p,c)` 圆内为空，圆上返回自身；`commonTangents` 返回两圆上的切点对。切线题通常要求半径正。
- `circleIntersectionArea` 求圆盘交面积，包含时为小圆面积，相离为 0。

*计算式*　线圆垂足 H、圆心到线距离 d，半弦长 $sqrt(r^2-d^2)$。两圆心距 d 非零时，公共弦中点距第一圆心
$ x=(d^2+r_1^2-r_2^2)/(2d), quad h=sqrt(r_1^2-x^2). $
先判同心和关系再代入，微小负被开方数截为 0。

公切线单位法向量 v 满足 `v·(O2-O1)=r1-s*r2`，`s=1` 为外公切线，`s=-1` 为内公切线。相切时切点对可能重合，改用切点处半径的垂线表示；重合正半径圆的空返回值代表无穷多公切线。

弓形面积为 $r^2(theta-sin theta)/2$，角度用弧度，`acos` 输入截到 `[-1,1]`。移动圆避障可将障碍半径加自身半径；多圆并面积需圆弧扫描等方法。

#code("计算几何/圆的交点、切线与交面积/圆.cpp", parts: ("circle-base", "intersections", "tangents", "intersection-area"))


#section-0.render(code)

]
