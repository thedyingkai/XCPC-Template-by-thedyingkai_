#let render(code) = [
#heading(level: 2, outlined: true)[积性函数大范围前缀和（杜教筛）] <book-dujiao>

求大范围前缀和 $M(n)=sum_(i=1)^n mu(i)$、$Phi(n)=sum_(i=1)^n phi(i)$。先 `DujiaoSieve ds; ds.init(B);`，`B>=1`，再调用 `ds.sumMu(n)` 返回 `i64`，`ds.sumPhi(n)` 返回精确 `i128`。

*递推*　由 $mu ast 1=epsilon$、$phi ast 1="id"$：
$ M(n)=1-sum_(b=2)^n M(floor(n/b)), $
$ Phi(n)=n(n+1)/2-sum_(b=2)^n Phi(floor(n/b)). $
从 `l=2` 分块，`q=n/l,r=n/q`，一块贡献 `(r-l+1)*F(q)`；小值查预筛，大值记忆化。

单次上界 `n` 常取 $B≈n^(2/3)$，典型时间 $O(n^(2/3))$，空间 $O(B+n/B)$。多询问共享缓存，状态数随上界分布变化；`init` 会清空缓存。

*改函数*　找 $h=f ast g$，令前缀和为 $H,F,G$：
$ g(1)F(n)=H(n)-sum_(b=2)^n g(b)F(floor(n/b)). $
要求 `H,G` 易求且 `g(1)` 可除；分块系数为 `G(r)-G(l-1)`。区间和用两个前缀相减。三角和先在 `i128` 中算，合数模下避免直接用 `inv2`。

题目：#link("https://judge.yosupo.jp/problem/sum_of_totient_function")[Sum of Totient Function]。

#code("数论/积性函数大范围前缀和（杜教筛）/杜教筛.cpp")


]
