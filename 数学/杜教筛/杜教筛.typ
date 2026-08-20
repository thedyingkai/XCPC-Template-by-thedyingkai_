`DujiaoSieve` 求远大于预筛范围的 $M(n)=sum_(i=1)^n mu(i)$ 和 $Phi(n)=sum_(i=1)^n phi(i)$。先调用 `init(B)` 线性筛到 $B>=1$，再用 `sumMu(n)` 或 `sumPhi(n)` 查询；前者返回 `i64`，后者返回精确 `i128`，均不取模。

由 $mu ast 1=epsilon$，把所有 $i<=n$ 按 $floor(n/i)$ 分组可得 $M(n)=1-sum_(l=2)^n M(floor(n/l))$；由 $phi ast 1=id$ 同理得到 $Phi(n)=n(n+1)/2-sum_(l=2)^n Phi(floor(n/l))$。相同商整段计算并记忆化，每个所需的商值只求一次。单次大查询常取 $B$ 约为 $n^(2/3)$，典型复杂度 $O(n^(2/3))$，实际可按内存和多询问分布调整。

改求其他函数时，应先找到容易求前缀和的狄利克雷卷积 $h=f ast g$ 且 `g(1)=1`，再重新推导递推；只替换线性筛数组会得到错误公式。题目要求取模时，三角和先在 `i128` 中完成再取模，合数模数下不要直接乘 `inv2`。

#link("https://judge.yosupo.jp/problem/sum_of_totient_function")[Library Checker · sum_of_totient_function]
