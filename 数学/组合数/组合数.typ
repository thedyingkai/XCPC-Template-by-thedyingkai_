`Comb::init(N,p)` 在质数模数 $p$ 下预处理 `0..N` 的阶乘和逆阶乘，要求 $0<=N<p$。随后 `C(n,k)`、`A(n,k)` 分别以 $O(1)$ 求组合数和排列数，越界或 `k` 非法时返回零；`starsBars(sum,boxes)` 求 $x_1+...+x_k=s$ 的非负整数解数，其中 $k$、$s$ 分别对应 `boxes`、`sum`，并且 `sum+boxes-1` 不能超过预处理上界。`batchInverse(a,p)` 只用一次快速幂求一组逆元，但每个元素模 $p$ 都必须非零。

阶乘法正确是因为 $C(n,k)=n!/(k!(n-k)!)$，而 `N<p` 保证这些阶乘在质数模数下可逆。若 $n>=p$，阶乘已经含零因子，应改用卢卡斯定理；合数模数下分母也未必可逆，应使用质数幂分解和中国剩余定理的任意模组合数板。

化组合式时常用四条等式：$k C(n,k)=n C(n-1,k-1)$；范德蒙德恒等式 $sum_k C(r,k)C(s,n-k)=C(r+s,n)$；曲棍球杆恒等式 $sum_(i=k)^n C(i,k)=C(n+1,k+1)$；以及 $sum_k C(n,k)=2^n$。二项式反演的两边是

$F(n)=sum_(k=0)^n C(n,k)G(k)$，

$G(n)=sum_(k=0)^n (-1)^(n-k) C(n,k)F(k)$。

容斥时，若 $A_S$ 表示下标集合 $S$ 中所有集合的交，则
$|A_1 union ... union A_m|=sum_(t=1)^m (-1)^(t+1) sum_(|S|=t)|A_S|$。
再记 $G_i=sum_(|S|=i)|A_S|$，恰好属于 $k$ 个集合的元素数为
$sum_(i=k)^m (-1)^(i-k) C(i,k)G_i$。

隔板法先明确变量是否允许为零：正整数解数是 $C(n-1,k-1)$，非负整数解数是 $C(n+k-1,k-1)$；有上下界时先平移下界，再对超过上界的变量容斥。写代码前先核对组合对象和所有下标的有效范围。

#link("https://judge.yosupo.jp/problem/binomial_coefficient_prime_mod")[Library Checker · binomial_coefficient_prime_mod]
