==== 用途

- 输入带 $gcd$、互质或整除条件的二维计数，把限制经 $mu$ 卷积改写成只按 $d$ 枚举的一维和；再配合整除分块计算 $floor(n/d)$ 相同的区间。
- 输出常见形态为 $sum_d h(d)floor(n/d)floor(m/d)$，其中 $h=f ast mu$；互质计数取 $h=mu$，$gcd$ 和取 $h=phi$。

==== 常用恒等式

- 狄利克雷卷积为 $(f ast g)(n)=sum_(d mid n) f(d)g(n/d)$。记 $1(n)=1$、$epsilon(1)=1$ 且 $epsilon(n>1)=0$、$id(n)=n$，则 $1 ast mu=epsilon$、$phi ast 1=id$。
- 除数形式：$F(n)=sum_(d mid n) f(d)$ 当且仅当 $f(n)=sum_(d mid n) mu(d)F(n/d)$。
- 有限倍数形式：$F(d)=sum_(d mid k, k<=N) f(k)$ 当且仅当 $f(d)=sum_(d mid k, k<=N) mu(k/d)F(k)$。

==== 最大公约数求和

- 具体推式为
  $sum_(i=1)^n sum_(j=1)^m f(gcd(i,j)) = sum_(d=1)^min(n,m) h(d) floor(n/d) floor(m/d)$。
- 统计 $gcd(i,j)=k$ 时先把两端同时除以 $k$，再统计互质数对。
- 区间 $[a,b] times [c,d]$ 的答案用四次二维前缀容斥。对右式做整除分块时，`pre` 应为 $h$ 的前缀和。
- 当前 `线性筛积性函数.cpp` 已给出 `mu`、`phi`，当前整除分块板已给出通用主循环，不需要再写一份莫比乌斯反演代码。

==== 改板

- 一般权值 $f(gcd)$ 先计算 $h=f ast mu$；若只需要 $1..N$，可枚举除数及其倍数在 $O(N log N)$ 内完成卷积。
- 把 `mu`、`phi` 改为前缀和前，若后续还需要单点值，应另存数组。
- $floor(n/d) floor(m/d)$ 及带权和可能溢出 `i64`，乘法中间量按题目范围改为 `i128`。

==== 板子题

- 洛谷 P2522「Problem b」、P3455「ZAP-Queries」。
