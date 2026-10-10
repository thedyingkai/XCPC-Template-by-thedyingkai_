#import "/计算几何/读题信号与区域赛样本/sources.typ": geom-sources, geom-source

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[平均重叠面积：交换积分后只剩三个面积] <geom-overlap-expectation>
设 $D=P-Q$，$P,Q$ 是有正面积的凸多边形，在产生正面积交叠的全部平移中按二维面积均匀选 $t$。令 $I(t)=op("area")(P inter (Q+t))$，用指示函数展开：

$ integral_(RR^2) I(t) dif t
  =integral_(RR^2) integral_P bold(1)_(x in Q+t) dif x dif t
  =integral_P op("area")(x-Q) dif x
  =op("area")(P) op("area")(Q). $

固定面元 $x in P$ 时，能覆盖它的平移为 $x-Q$，面积恒等于 $Q$ 的面积。$D$ 外交叠面积为零，因此可以把全平面积分限制在 $D$；边界作为零测集不改变平均。于是

$ op("E")[I]=
  (op("area")(P) op("area")(Q))/(op("area")(P-Q)). $

若全程保留两倍面积 $A_2,B_2,D_2>0$，输出公式为 $A_2 B_2/(2D_2)$。先转换到 `d128` 再做乘法，或确认整数乘积的界后保持整数。三个面积都应在统一坐标尺度下计算。

检查例子：两个单位轴平行正方形的差集合是边长 $2$ 的正方形，条件期望为 $1/4$；边长分别为 $a,b$ 的正方形则为 $a^2 b^2/(a+b)^2$。结果不会超过两者面积的较小值，可作为输出自检。

2025 沈阳 G 正是此模型。若平移在另一个区域中均匀、只有离散整点平移、同时允许旋转，或随机分布带非均匀权重，不能直接除差多边形面积。#geom-source("shenyang25")。



]
