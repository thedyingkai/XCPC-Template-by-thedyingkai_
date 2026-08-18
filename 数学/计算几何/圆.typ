==== 用途

- 输入圆、直线或另一个圆，可判定位置关系并求交点、公切线切点及两圆交面积；线段与圆的问题需再过滤交点范围。

==== 接口与边界

- 依赖 `点与直线基础.cpp`。`circleRelation` 返回：`0` 相离、`1` 外切、`2` 相交、`3` 内切、`4` 内含、`5` 重合。
- `lineCircleIntersection` 求无限直线与圆的交点；线段需再用 `pointOnSegment` 过滤。
- `circleIntersection` 在两圆重合时也返回空数组，调用前用 `circleRelation` 区分。
- `commonTangents` 返回每条公切线分别在两圆上的切点。

==== 改板

- 圆形物体绕圆障碍运动时，把障碍半径加上物体半径，再按点运动处理。
- 多圆面积不能两两容斥，需改用圆弧角度扫描或 Green 公式。

==== 板子题

- Codeforces 600D「Area of Two Circles」。
