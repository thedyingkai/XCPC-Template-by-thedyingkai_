==== 连续点插值的用途

已知低次多项式在连续整数点的值时，`lagrangeConsecutive(y,x,p)` 由 `y[i]=P(i)` 在 $O(k)$ 内求 $P(x)$，常用于把一个多项式项的前缀和外推到巨大下标。要求 $p$ 为质数且次数上界 $k<p$；`x` 会先模 $p$ 规范化，落在已有采样点时直接返回样本。

在节点 $0..k$ 上，第 $i$ 个拉格朗日基函数的分母是 $(-1)^(k-i)i!(k-i)!$，分子用 `x-j` 的前缀积和后缀积一次算完。若被求和项为 $d$ 次多项式，且模数满足 $d+1<p$，其前缀和至多为 $d+1$ 次，因此先算 `0..d+1` 的前缀值就能外推。采样点不连续时使用多点插值，插值点须在模 $p$ 意义下互异。

`lagrangeConsecutiveShift(y,c,m,p,convolution)` 批量返回 $P(c),...,P(c+m-1)$，其中 `n=y.size()`；卷积函数必须接收并返回同一质数模数下的零下标数组，使用 NTT 时复杂度为 $O((n+m)log(n+m))$。要求 `m>=0` 且 `max(n,m)<p`，还要确认卷积长度受到所选 NTT 模数支持。

#link("https://judge.yosupo.jp/problem/shift_of_sampling_points_of_polynomial")[Library Checker · shift_of_sampling_points_of_polynomial]
