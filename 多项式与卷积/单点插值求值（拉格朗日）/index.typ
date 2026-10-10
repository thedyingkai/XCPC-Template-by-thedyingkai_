#let render(code) = [
#heading(level: 2, outlined: true)[单点插值求值（拉格朗日）] <book-lagrange>

已知次数不超过 k 的多项式在 `0..k` 的值，`lagrangeConsecutive(y,x,p)` 求 `P(x)`，时间、空间 $O(k)$。要求 p 为质数、`k<p`；x 规范到模 p，命中样本直接返回。

第 i 项分母为 $(-1)^(k-i)i!(k-i)!$，分子用 `x-j` 的前后缀积。d 次多项式的前缀和在 `d+1<p` 时次数至多 d+1，取 `0..d+1` 的前缀样本即可外推。

`lagrangeConsecutiveShift(y,c,m,p,convolution)` 批量求 `P(c)..P(c+m-1)`。令 `n=y.size()`，要求 `m>=0,max(n,m)<p`；回调收发同模数的 0 下标数组。NTT 实现时间 $O((n+m)log(n+m))$，还需检查变换长度。

任意采样点用多点插值，点在模意义下须互异。题目：#link("https://judge.yosupo.jp/problem/shift_of_sampling_points_of_polynomial")[Shift of Sampling Points]。

#code("多项式与卷积/单点插值求值（拉格朗日）/拉格朗日插值.cpp", mode: "full")

参见 #link(<book-generating-function>)[生成函数计数建模]。

参见 #link(<book-geometric-area>)[有向面积总和转卷积的应用]。

参见 #link(<chapter-recurrence>)[线性递推与 Bostan-Mori]。

#pagebreak()


]
