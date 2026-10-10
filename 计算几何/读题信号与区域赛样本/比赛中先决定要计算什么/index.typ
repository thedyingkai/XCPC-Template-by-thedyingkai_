#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[比赛中先决定要计算什么] <geom-choose-model>
先画小图，写清对象是点、射线、线段、无限直线，还是填充的闭区域。再决定答案需要距离与角度的数值，还是只需要左右、先后、包含等组合关系。后者尽量保留整数谓词，最后输出时才做开方、除法或求角。

同一个“点在一侧”条件，可以写成叉积符号，也可以写成极角区间；“最远”可能是欧氏距离、固定方向投影或曼哈顿距离；“相交”可能只要接触，也可能要求正面积。把这些词展开成定义，常比先挑模板函数更重要。

#table(columns: (1fr, 1fr), inset: 4pt,
  table.header([题面信号], [优先尝试与本章位置]),
  [所有点在过定点直线的一侧；删点后不包围定点], [#link(<geom-separation>)[分离直线与开半圆]],
  [存在／任意朝向都覆盖至少 $k$ 点], [#link(<geom-coverage-width>)[环形间隔，区分 $k-1$ 与 $k$]],
  [变量无界；满足尽量多的线性不等式], [#link(<geom-unbounded-scale>)[消去正的常数项，保留方向]],
  [比凸包多一个顶点；必须出现凹角], [#link(<geom-local-hull>)[替换一条边、最小损失]],
  [方向固定，求最远／最近投影], [#link(<geom-support>)[凸包支撑点与卡壳单调性]],
  [许多多边形的面积总和], [#link(<geom-edge-contribution>)[有向边贡献与组合系数]],
  [随机方向／边界位置／区域内点], [#link(<geom-probability-measure>)[先确定概率对应的测度]],
  [平移后碰撞；所有碰撞位置中随机选一个], [#link(<geom-minkowski>)[闵可夫斯基差]、#link(<geom-overlap-expectation>)[交换积分]],
  [配重位置随机，新重心决定结果], [#link(<geom-affine-centroid>)[仿射变换与整体整数化]],
  [反射直到回到起点], [#link(<geom-reflection>)[不变量、展开与有理周期]],
  [格点上反复取中点], [#link(<geom-midpoint>)[二进分母、最少步数与构造]],
  [曼哈顿与切比雪夫距离混合], [#link(<geom-metrics>)[距离不等式与坐标变换]],
  [对象少、覆盖整个外框], [#link(<geom-finite-structure>)[角点、极端点与有限结构]],
  [第一次碰撞；半平面覆盖], [#link(<geom-topology>)[父子关系与平面划分]],
)



]
