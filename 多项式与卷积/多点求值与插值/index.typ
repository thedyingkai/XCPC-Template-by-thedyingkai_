#let render(code) = [
#heading(level: 2, outlined: true)[多点求值与插值] <book-multipoint>

固定模 `998244353`，系数低次在前。`ProductTree(xs).evaluate(f)` 按输入点序返回函数值；`interpolate(ys)` 返回次数小于点数的插值多项式。

求值允许重复点；插值要求横坐标在模意义下两两不同，`0` 与 `998244353` 是同一点。相同点集可复用对象，调整点序须同时调整 `ys`。

点数 `n`、输入系数数 `m`，取 `N=max(n,m)`，求值 $O(N log^2 N)$，插值 $O(n log^2 n)$；乘积树占 $O(n log n)$ 空间，求值另需输入多项式的工作空间。

*公式*　树节点存 $P(x)=product_i(x-x_i)$。求值自顶向下取余，到叶子读常数。插值先批量求 $P'(x_i)$，叶子设 $w_i=y_i/P'(x_i)$，向上合并
$ F=F_L P_R+F_R P_L. $
这对应 $F(x)=sum_i (y_i/P'(x_i))P(x)/(x-x_i)$。

重复点是同值约束时可先去重，不同纵值则无解；导数约束属于埃尔米特插值。连续点且只问少量点时可用拉格朗日单点求值。

题目：#link("https://judge.yosupo.jp/problem/multipoint_evaluation")[多点求值]、#link("https://judge.yosupo.jp/problem/polynomial_interpolation")[插值]。

#code("多项式与卷积/多点求值与插值/多点求值与插值.cpp", mode: "full")


]
