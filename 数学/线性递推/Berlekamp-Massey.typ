`berlekampMassey(sequence)` 在质数模数下，从一段序列前缀求与它相容的最短线性递推，返回的 `c` 满足 $a_n=sum_(i=1)^k c_(i-1)a_(n-i)$。处理到每个新位置时，若当前递推预测的差值非零，就用上一次使线性复杂度增长的递推乘一个适当系数和位移来消掉该差值；算法始终保持已经扫描的前缀全部满足当前关系。

`nth(initial,c,n)` 再用多项式取模于 $O(k^2 log n)$ 求第 $n$ 项，`n` 从零开始，初值至少提供前 $k$ 项。模数必须是质数，因为修正系数需要非零差值的逆元；全零序列返回空递推。有限前缀只能保证“与样本相容”，通常至少提供真实阶数两倍以上的连续项，并拿额外项复核。已知递推时直接调用 `nth`；阶数很大时改用 Bostan--Mori。

#link("https://judge.yosupo.jp/problem/find_linear_recurrence")[Library Checker · find_linear_recurrence]
