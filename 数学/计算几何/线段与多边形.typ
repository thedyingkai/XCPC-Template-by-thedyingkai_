==== 用途

- 输入点、线段和简单多边形，可判断点是否在多边形内、两线段如何相交以及整条线段是否留在多边形内，并计算线段间距离。

==== 接口与边界

- 依赖 `点与直线基础.cpp`；`pointInPolygon` 把边界算作内部。
- `segmentIntersection` 的类型为：`0` 不交、`1` 严格相交、`2` 共线重叠、`3` 单点相交。类型为 `2` 时后两个返回值是重叠段端点。
- `segmentInPolygon` 也允许线段落在边界上；要求严格位于内部时需同时修改端点和边界相交判定。

==== 板子题

- AOJ CGL_2_B「Intersection」、CGL_2_D「Distance」、CGL_3_C「Point in a Polygon」。
