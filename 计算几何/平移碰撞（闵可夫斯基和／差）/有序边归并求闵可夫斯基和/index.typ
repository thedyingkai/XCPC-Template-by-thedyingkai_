#import "/template/frame.typ": extract-code
#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[有序边归并求闵可夫斯基和] <geom-minkowski-merge>
两个严格凸包的边向量都按极角循环递增。先把每个凸包旋转到最低 $y$、再最低 $x$ 的顶点，从正 $x$ 轴开始的边方向就具有一致线性顺序。和多边形从两个起点的和出发，每次取较小极角的边；同向边同时推进并合并长度。

#trick-code(extract-code(
  read("闵可夫斯基和与差.cpp"),
  parts: "minkowski",
  path: "计算几何/平移碰撞（闵可夫斯基和／差）/有序边归并求闵可夫斯基和/闵可夫斯基和与差.cpp",
))

这个实现直接接 `convexHull(...,false)`，允许空集、单点与线段；单点求和就是平移。正常严格凸包归并为 $O(n+m)$。输入若来自任意点集，先求凸包的总成本另算。

几个必须固定的约定：

- 两个多边形都是逆时针，不重复首点，相邻顶点互异，边上冗余共线中点已经去掉。
- 同时把 $x,y$ 取负是旋转 $180^degree$，行列式为正；$-Q$ 保持逆时针，无需逆序，但起点要重选。
- 叉积为零的边可能反向。先判 `sameRay` 才可同时推进，反向边按半平面顺序分别处理。
- 最后一条边把路径带回起点，删除重复末点；点、线段不能当作拥有正面积的多边形套期望公式。
- 坐标加减、取负与边向量仍在 `i64` 中执行。即使叉积用 `i128`，也须先保证这些操作不溢出。

固定方向的支撑函数满足 $h_(P+Q) (v)=h_P (v)+h_Q (v)$，可解释有序边合并为什么能得到正确外轮廓。#link("https://doc.cgal.org/latest/Minkowski_sum_2/index.html")[CGAL 的闵可夫斯基和说明]给出了凸多边形边序归并的方法。



]
