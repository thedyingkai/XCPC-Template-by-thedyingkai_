==== 接口与边界

- 整数坐标的点积、叉积返回 `i128`；交点和距离返回 `d128`。
- `lineIntersection` 要求两直线不平行；`normalize`、`distancePL` 要求方向向量非零。
- 几何符号判断使用绝对误差 `GEOM_EPS`，凸包排序仍按坐标原值比较；数值尺度变化时重新评估误差。
- 只比较距离时用 `square`，可避免开方和额外误差。

==== 板子题

- AOJ CGL_1_C「Counter-Clockwise」、CGL_2_C「Cross Point」。
