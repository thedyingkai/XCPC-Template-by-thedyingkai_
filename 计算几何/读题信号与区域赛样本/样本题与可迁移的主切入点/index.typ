#import "/计算几何/读题信号与区域赛样本/sources.typ": geom-sources, geom-source
#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[样本题与可迁移的主切入点] <geom-contest-samples>
下表保留原讨论选取的 2021—2025 年 15 场区域赛、17 道题。它是定向选题的技巧索引；没有枚举所有赛题，不能把各类数量换成考查概率。题目完整条件和计数口径以链接中的原题、题解为准。

#table(columns: (auto, 1fr, 1fr), inset: 4pt,
  table.header([赛站], [题目与资料], [主切入点]),
  [2021 ICPC 澳门], [#link(geom-sources.macau21)[C — Laser Trap]], [凸包外部、严格分离、开半圆],
  [2021 CCPC 威海], [#link(geom-sources.weihai21)[J — Circular Billiard Table]], [圆内反射、固定转角、$gcd$ 周期],
  [2021 CCPC 桂林], [#link(geom-sources.guilin21)[F — Illuminations II]], [按边拆期望，概率为边界长度比例],
  [2022 ICPC 南京], [#link(geom-sources.nanjing22)[M — 清空水箱]], [局部最低点与整段水平平台],
  [2022 ICPC 杭州], [#link(geom-sources.hangzhou22)[J — Painting]], [第一次碰撞形成父子关系与凸链],
  [2022 CCPC 威海], [#link(geom-sources.weihai22)[C — Grass]], [五点见证集、同向重叠与反向相交],
  [2022 CCPC 绵阳], [#link(geom-sources.mianyang22)[F — Infinite Strife]], [取补集，侧别组合与直线划分区域],
  [2023 ICPC 济南], [#link(geom-sources.jinan23)[M — Almost Convex Polygon]], [凸包必选顶点、插一点与空三角形],
  [2023 ICPC 沈阳], [#link(geom-sources.shenyang23)[I — Three Rectangles]], [四个角与三张矩形、贴边结构],
  [2024 ICPC 昆明], [#link(geom-sources.kunming24)[H — Horizon Scanning]], [任意朝向覆盖，最大 $k$ 步间隔],
  [2024 CCPC 哈尔滨], [#link(geom-sources.harbin24)[B — Concave Hull]], [外凸包面积减最小三角形损失],
  [2024 CCPC 济南], [#link(geom-sources.jinan24)[G — The Wheel of Fortune]], [重心仿射像、面积概率、整数化],
  [2024 CCPC 郑州], [#link(geom-sources.midpoint24)[C — Middle Point]], [约分分母为二的幂、倒推构造],
  [2024 CCPC 郑州], [#link(geom-sources.zhengzhou24)[I — Best Friend, Worst Enemy]], [距离不等式排除稠密候选],
  [2025 ICPC 南京], [#link(geom-sources.nanjing25)[B — What, More Kangaroos?]], [无界放大后二元不等式只看方向],
  [2025 ICPC 南京], [#link(geom-sources.nanjing25)[M — Many Convex Polygons]], [有向边贡献、组合计数、卷积],
  [2025 ICPC 沈阳], [#link(geom-sources.shenyang25)[G — Collision Damage]], [差多边形可行域、期望交面积],
)



]
