==== 用途

- 输入模意义下的一段序列前缀，求与它相容的最短线性递推；再输入下标 $n$，由递推和初值求第 $n$ 项。

==== 接口与边界

- `berlekampMassey(sequence)` 在质数模数下求能解释已知序列的最短线性递推，返回 `c`，满足 $a_n = sum_(i=1)^k c_(i-1) a_(n-i)$。
- `nth(initial,c,n)` 用多项式取模在 $O(k^2 log n)$ 内求第 $n$ 项，`n` 从 $0$ 开始；`initial` 至少提供前 $k$ 项。
- 默认模数为 $998244353$；序列不足以唯一确定真实递推时，算法只能返回与已知前缀相容的递推。

==== 使用与 trick

- 通常至少提供真实阶数两倍以上的连续项，并用更多已知项复核返回递推。
- 全零序列返回空递推，之后各项按 $0$ 处理；换合数模数会破坏求逆步骤。
- 已知递推时直接调用 `nth`，不要先跑 Berlekamp--Massey；阶数很大时再改用 NTT/Bostan--Mori。

==== 板子题

- Library Checker「Find Linear Recurrence」「K-th Term of Linear Recurrence」。
