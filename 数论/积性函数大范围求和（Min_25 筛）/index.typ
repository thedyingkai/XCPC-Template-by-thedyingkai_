#let render(code) = [
#heading(level: 2, outlined: true)[积性函数大范围求和（Min_25 筛）] <book-min25>

求乘性函数前缀和，要求 `f(1)=1`、`f(p)=c0+c1*p+c2*p*p`，任意质数幂 `f(p^e)` 可快速算。调用 `Min25Sieve(n,mod,{c0,c1,c2},primePower).solve()`。

回调 `primePower(p,e,peMod)` 返回 `f(p^e)`，第三参已是 `p^e mod mod`，e=1 必须与系数一致。正模数可合数，典型时间 $O(n^(3/4)/log n)$、空间 $O(sqrt n)$；不同 n 分别构造。

*套题配置*

- 约数个数：系数 `{2,0,0}`，回调 `e+1`。
- phi：`{-1,1,0}`，回调求 `p^(e-1)*(p-1)`；另算所需幂，不能用已取模的 `peMod/p`。
- `f(p^e)=p^e*(p^e-1)`：`{0,-1,1}`，回调 `peMod*(peMod-1)` 并归一化，乘法先扩宽。

*筛与递归*　对所有整除商 x 存 `G[t](x)=sum(p^t,p<=x)`，t=0、1、2。初值为整数幂和，处理质数 p 时从大 x 向小 x 更新：
$ G_t(x)<-G_t(x)-p^t(G_t(floor(x/p))-sum_(q<p,q "为质数")q^t). $
再按最小质因子递增枚举 `p^e*u`，u 的质因子须大于 p，单独计纯质数幂，最外补 f(1)。

`primeSum(x)` 仅接受本实例预处理的整除商。只数质数用 `{1,0,0}` 后直接 `primeSum(n)`；solve 会计乘性函数在合数处的值。需精确质数数目时选大于答案的模数。

扩到更高次质数多项式须同时扩系数、幂和初值、质数前缀与筛循环。

题目：#link("https://judge.yosupo.jp/problem/counting_primes")[Counting Primes]、#link("https://judge.yosupo.jp/problem/sum_of_multiplicative_function")[Sum of Multiplicative Function]。

#code("数论/积性函数大范围求和（Min_25 筛）/Min_25 筛.cpp")


]
