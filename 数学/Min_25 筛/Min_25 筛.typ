Min_25 筛用于求 $sum_(i=1)^n f(i)$，其中 $f$ 是乘性函数、$f(p)$ 能写成质数 $p$ 的低次多项式，并且每个 $f(p^e)$ 可以快速计算。`Min25Sieve(n,mod,{c0,c1,c2},primePower).solve()` 约定 $f(1)=1$、$f(p)=c_0+c_1p+c_2p^2$，返回答案模 `mod`；回调 `primePower(p,e,peMod)` 返回 $f(p^e)$，第三个参数是 $p^e mod mod$，且 `e=1` 时必须与系数给出的 $f(p)$ 一致。

板子先对所有不同的 $floor(n/i)$ 筛出 $sum_(p<=x)1$、$sum p$、$sum p^2$，再按最小质因子递增枚举乘性分解。递归状态只允许使用不小于指定下标的质数，因此每个大于一的整数按其最小质因子恰好统计一次；这就是 `dfs` 不重不漏的原因。典型时间为 $O(n^(3/4)/log n)$、空间为 $O(sqrt(n))$，不同 `n` 需分别构造实例。

本实现不使用模逆，正模数不要求为质数。若 $f(p)$ 次数高于二次，必须同步扩展系数、幂和初值、质数前缀和筛除循环，不能只改回调。回调只计算一个质数幂，不要再枚举其他质因子。例：$f(p^e)=p^e(p^e-1)$ 时系数为 `{0,-1,1}`，回调用 `peMod*(peMod-1)` 并规范化。

只统计不超过 $n$ 的质数个数时，构造 `Min25Sieve(n,mod,{1,0,0},...)` 后直接调用 `primeSum(n)`；它返回 $pi(n) mod mod$。需要精确值时应选大于答案的正 `i64` 模数，例如 `(1LL<<62)-1` 足以覆盖本接口的有符号 `i64` 范围。不要把高次质数幂的回调设为零后调用 `solve()`：`solve()` 统计的是完整乘性函数，仍会把含多个不同质因子的合数计入。

#link("https://judge.yosupo.jp/problem/counting_primes")[Library Checker · counting_primes]

#link("https://judge.yosupo.jp/problem/sum_of_multiplicative_function")[Library Checker · sum_of_multiplicative_function]
