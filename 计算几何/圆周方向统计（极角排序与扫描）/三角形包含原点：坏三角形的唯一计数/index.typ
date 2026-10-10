#import "/template/frame.typ": extract-code
#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[三角形包含原点：坏三角形的唯一计数] <geom-origin-triangles>
前提：所有向量非零，任意两向量不共线，即没有同向或反向。令 $k_i$ 为起点 $i$ 后、逆时针角差严格在 $(0,pi)$ 的点数，则

$ N_"inside"=binom(n,3)-sum_i binom(k_i,2). $

原点不在三角形中等价于三个方向能放入某个开半圆。沿三个方向的环形次序，此时恰有一个间隔大于 $pi$，其后那个顶点就是唯一的窗口起点；从该起点后选两个方向，坏三角形只计一次。其余三角形严格包含原点。

#trick-code(extract-code(
  read("包含原点的三角形计数.cpp"),
  parts: "origin-triangles",
  path: "计算几何/圆周方向统计（极角排序与扫描）/三角形包含原点：坏三角形的唯一计数/包含原点的三角形计数.cpp",
))

同向点使“唯一起点”需要重新按组设计贡献，反向点会产生原点在边界上的三角形，不能直接套此函数。四条坐标轴构成的四个三角形都只让原点落在边上，严格内部数为 $0$；把这个例子代入未修正公式会得到错误结果。代码用断言暴露违背前提的输入，不能把断言关闭当作支持退化。

计数结果可能达到 $binom(n,3)$，先提升再相乘。固定观察点为 $O(n log n)$；对每个输入点做一次通常是 $O(n^2 log n)$，且要先去掉观察点本身。



]
