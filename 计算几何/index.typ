#import "读题信号与区域赛样本/index.typ" as section-0
#import "点线基础与夹角计算/index.typ" as section-1
#import "线段相交与多边形包含/index.typ" as section-2
#import "半平面约束交集/index.typ" as section-3
#import "圆的交点、切线与交面积/index.typ" as section-4
#import "圆周方向统计（极角排序与扫描）/index.typ" as section-5
#import "凸包极值与点定位（旋转卡壳）/index.typ" as section-6
#import "多边形面积与面积总和（有向边贡献）/index.typ" as section-7
#import "矩形面积并（扫描线）/index.typ" as section-8
#import "平移碰撞（闵可夫斯基和／差）/index.typ" as section-9
#import "几何概率与随机重叠面积/index.typ" as section-10
#import "面积重心与随机配重/index.typ" as section-11
#import "坐标变换后的几何不变量/index.typ" as section-12
#import "整点中点的可达性与最少步数/index.typ" as section-13
#import "曼哈顿与切比雪夫距离/index.typ" as section-14
#import "三角形边长的可行性/index.typ" as section-15
#import "少量图形覆盖（有限见证集）/index.typ" as section-16
#import "地形局部最低区域/index.typ" as section-17
#import "镜面反射路径与周期/index.typ" as section-18
#import "碰撞结构与平面分割/index.typ" as section-19
#import "数值谓词、精确交点与退化处理/index.typ" as section-20
#import "几何代码依赖与接口约定/index.typ" as section-21

#let render(code) = [
#heading(level: 1, outlined: true)[计算几何] <chapter-geometry>

本章将区域赛题中的几何转化整理为“题面信号 → 数学模型 → 推导 → 边界 → 实现”。前面的点线、线段、多边形、圆、凸包与半平面交负责基础接口；这里补充选模型的理由和组合用法。代码使用板子已有的 `i64/i128/d128` 与 `Point<T>`，新增整数点别名为 `IP`，不覆盖原来的浮点别名 `P`。


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

#section-4.render(code)

#section-5.render(code)

#section-6.render(code)

#section-7.render(code)

#section-8.render(code)

#section-9.render(code)

#section-10.render(code)

#section-11.render(code)

#section-12.render(code)

#section-13.render(code)

#section-14.render(code)

#section-15.render(code)

#section-16.render(code)

#section-17.render(code)

#section-18.render(code)

#section-19.render(code)

#section-20.render(code)

#section-21.render(code)

]
