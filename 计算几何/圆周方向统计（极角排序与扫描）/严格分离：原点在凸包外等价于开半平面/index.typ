#import "/计算几何/读题信号与区域赛样本/sources.typ": geom-sources, geom-source

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[严格分离：原点在凸包外等价于开半平面] <geom-separation>
对非空有限点集 $S$，

$ O in.not op("conv")(S)
  arrow.l.r.double exists v: forall p in S, v dot.op (p-O)>0. $

可从凸包上距 $O$ 最近的点 $q$ 推导。若 $O$ 不在凸包中，则 $q!=O$；最近性给出 $(q-O) dot.op (p-q)>=0$，因此 $(q-O) dot.op (p-O)>=|q-O|^2>0$。反过来，所有点的凸组合也满足正投影，故不能等于 $O$。

所以删最少点后让 $O$ 在凸包外，答案为“总数减最大开半圆覆盖”。原点重合的点须删除；边界上含 $O$ 仍不算“在凸包外”。如果题目只要求 $O$ 不在严格内部，条件可能转成闭半平面，须重新处理凸包退化的维度。

2021 澳门 C 用所有发射器对间的激光阻挡逃离。凸包边界形成包围；存在严格分离方向时可沿远离全部发射器的一侧逃离。原题额外排除了原点落在激光等边界情形。把该题的物理阻挡结论迁移到其他障碍模型前，先确认凸包边界确实由障碍构成。#geom-source("macau21")。



]
