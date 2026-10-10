#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[新增代码的依赖、返回值与复杂度] <geom-code-contract>
`计算几何技巧.cpp` 汇总各功能目录中的独立代码文件；各文件通过相对路径包含实际依赖，点线基础最终依赖起始头文件。整文件可直接 include；从 PDF 复制片段时，先复制点线基础和 `integer-polar` 片段，需要构建凸包时再复制 `convex-hull`。各段名称独立，不需要另写一套点结构。

片段额外依赖：`coverage-width` 使用 `angle` 中的 `normAngle` 与 `GEOM_PI`；其余新增片段在点线基础、`integer-polar` 已就绪时可以独立复制。闵可夫斯基归并不会替输入求凸包，输入为任意点集时由调用者先执行 `convexHull(...,false)`。

#table(columns: (auto, 1fr, auto), inset: 4pt,
  table.header([接口], [关键前提与返回], [时间]),
  [`orient128`], [整数点；先提升差值，行列式仍须装入 i128], [$O(1)$],
  [`PolarLess`／`sameRay`], [非零整数方向；严格圆周顺序／同向关系], [$O(1)$],
  [`normAngle`／`signedAngle`], [有限角度、正周期／非零向量；弧度], [$O(1)$],
  [`maxHalfPlane`], [开或闭半圆最大非零点数；保留同向权重], [$O(n log n)$],
  [`coverageWidth`], [闭区间；返回存在与任意朝向的最小宽度], [$O(n log n)$],
  [`countOriginTriangles`], [任意两方向不共线；严格内部，i128 计数], [$O(n log n)$],
  [`convexLocation`], [严格 CCW 凸包；外部 -1、边界 0、内部 1], [$O(log n)$],
  [`signedArea2`], [环序；两倍有向面积，最后决定是否取绝对值], [$O(n)$],
  [`minkowskiSum/Difference`], [严格 CCW 凸包，允许点段；无重复首点], [$O(n+m)$],
  [`exactLineIntersection`], [非退化无限直线；最简分数或 nullopt], [$O(log M)$],
  [`midpointConstruction`], [矩形四角初始集；最优操作序列或 nullopt], [$O(log M)$],
)

表中 $M$ 表示对应整数运算的数值量级，分数约分与中点分母分析含 gcd 成本。点定位的空集、单点、线段分支为常数时间。几何坐标的加减与最终结果、叉积和累加量、分数分子都要满足各自类型界。


#pagebreak()


]
