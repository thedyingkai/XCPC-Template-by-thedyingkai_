#import "/template/frame.typ": extract-code
#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[O(log n) 凸多边形点定位] <geom-convex-query>
对于严格凸包 $p_0,dots,p_(h-1)$，从 $p_0$ 向其余顶点连线形成有序扇形。先检验点 $q$ 是否处于 $p_0p_1$ 与 $p_0p_(h-1)$ 之间；在扇形内二分找到两条相邻射线，再检验 $q$ 在对应外边的哪一侧。

#trick-code(extract-code(
  read("凸多边形点定位.cpp"),
  parts: "convex-query",
  path: "计算几何/凸包极值与点定位（旋转卡壳）/O(log n) 凸多边形点定位/凸多边形点定位.cpp",
))

返回值分别区分外部、边界、严格内部；不能只用布尔值再在调用处猜边界。与第一条、最后一条扇边共线时须检验在线段上，不能把无限射线上所有点都算边界。内部扇形对角线上的点仍可在严格内部，它不是多边形边界。

前提为逆时针严格凸包，且没有重复首点。空集、单点、两点分别处理；保留共线边点的凸包先删除冗余点，再用这个二分。准备凸包为 $O(n log n)$，每次查询 $O(log h)$。一般简单多边形仍使用前面 $O(n)$ 的射线或绕数判定。



]
