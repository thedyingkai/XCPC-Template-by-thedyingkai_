#let render(code) = [
#heading(level: 2, outlined: true)[线段相交与多边形包含] <book-segments-polygon>

简单多边形顶点按边界顺序给出，顺逆时针均可。`pointInPolygon(q,p)` 判断闭区域，含边界，时间 $O(n)$；射线过顶点按半开规则计一次。

`segmentIntersection` 返回类型：0 不交、1 严格相交、2 共线重叠、3 单点相交；支持退化点段，类型 2 另返回重叠端点。`distanceSS` 相交为 0，否则取四次点到线段距离的最小值，两接口均 $O(1)$。

`segmentInPolygon` 判断整段处于闭区域：端点先在区域内，收集与每边的交点参数，再检查相邻参数间的中点。当前总时间 $O(n^2)$，允许沿边界行走。

严格内部版本须同时排除边界端点、重叠边和中途接触，不能只改一次点包含判断。

#code("计算几何/线段相交与多边形包含/线段与多边形.cpp", parts: ("point-in-polygon", "segment-intersection", "segment-in-polygon"))


]
