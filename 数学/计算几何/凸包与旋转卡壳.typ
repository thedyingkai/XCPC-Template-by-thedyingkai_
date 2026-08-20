`convexHull(points,false)` 对点排序去重后维护上下凸链，返回不重复首点的逆时针凸包，并删除边上的共线中间点。每个点至多进出栈一次，所以排序后扫描为线性时间，总复杂度 $O(n log n)$。传 `keepCollinear=true` 会保留边界共线点；所有点共线时直接返回排序后的全部点。

`diameter2(hull)` 在环序凸包上用旋转卡壳求最远点对距离平方。固定一条边时，对踵点到该边的三角形面积先增后减，因此指针只需单向移动一周；更新当前边两端到对踵点的距离即可覆盖最远点对。输入必须已经是凸包环序，整数点返回 `i128`。若要输出点对，在更新最大值时同步记录下标；多次判断点在凸多边形内，则固定一个顶点后二分扇区可做到单次 $O(log n)$。

#link("https://judge.yosupo.jp/problem/static_convex_hull")[Library Checker · static_convex_hull]
