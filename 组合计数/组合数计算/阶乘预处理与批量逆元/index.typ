#let render(code) = [
#heading(level: 3, outlined: true)[阶乘预处理与批量逆元] <book-variant-168>

`Comb cb; cb.init(N,p);` 在质数模 p 下预处理阶乘、逆阶乘，要求 `0<=N<p`。时间 $O(N+log p)$、空间 $O(N)$；`cb.C(n,k)`、`cb.A(n,k)` 查询 $O(1)$，非法下标或超表范围返回 0。

`cb.starsBars(sum,boxes)` 求非负整数和的方案，所需 `sum+boxes-1` 不超过 N。`batchInverse(a,p)` 用前后缀积和一次快速幂，时间 $O(|a|+log p)$，每项模 p 须非零。n 达到 p 时用 Lucas；合数模用任意模组合数。

*常用恒等式*
$ k binom(n,k)=n binom(n-1,k-1), quad sum_k binom(n,k)=2^n, $
$ sum_k binom(r,k)binom(s,n-k)=binom(r+s,n), $
$ sum_(i=k)^n binom(i,k)=binom(n+1,k+1). $

*二项式反演*
$ F(n)=sum_(k=0)^n binom(n,k)G(k), quad G(n)=sum_(k=0)^n(-1)^(n-k)binom(n,k)F(k). $

*容斥*　令 `Gi` 为所有 i 个集合交集大小之和，恰属于 k 个集合的数量为 $sum_(i=k)^m(-1)^(i-k)binom(i,k)G_i$；k=0 时 `G0` 取全集大小。

k 个正整数和 n：$binom(n-1,k-1)$；非负整数：$binom(n+k-1,k-1)$。有下界先平移，有上界再容斥，空盒等退化情形按定义处理。

题目：#link("https://judge.yosupo.jp/problem/binomial_coefficient_prime_mod")[Binomial Coefficient Prime Mod]。

#code("组合计数/组合数计算/阶乘预处理与批量逆元/组合数.cpp", parts: ("comb", "batch-inverse"))


]
