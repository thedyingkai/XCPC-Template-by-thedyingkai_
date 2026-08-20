`ProductTree(xs).evaluate(f)` 在任意一批横坐标求 $f(x_i)$；`interpolate(ys)` 从点 $(x_i,y_i)$ 恢复唯一的次数小于点数的多项式。乘积树每个节点保存该区间的 $product(x-x_i)$，向下取余即可批量求值；插值则用根多项式导数在 $x_i$ 的值作为分母，再从叶到根合并。两者复杂度均为 $O(n log^2 n)$。

求值允许重复横坐标，插值要求横坐标两两不同，否则导数分母为零。对象会保存整棵树的多项式，空间为 $O(n log n)$ 量级。取值点恰为连续的 `0..k` 且只问少数点时，连续点 Lagrange 更短；横坐标任意或需要整批结果时才使用乘积树。

#link("https://judge.yosupo.jp/problem/multipoint_evaluation")[Library Checker · multipoint_evaluation]

#link("https://judge.yosupo.jp/problem/polynomial_interpolation")[Library Checker · polynomial_interpolation]
