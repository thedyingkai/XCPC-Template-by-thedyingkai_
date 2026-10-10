#let render(code) = [
#heading(level: 2, outlined: true)[线性递推第 n 项（Bostan-Mori）] <book-bostan-mori>

`bostanMori(P,Q,n)` 求形式分式 `P/Q` 的第 n 项，`Q[0]!=0`，n 为 0 下标 `u64`。分子次数可高于分母，非零常数分母也支持。固定模 `998244353`，依赖 `poly998`。

*每轮折半*　算 `U=P*Q(-x)`、`V=Q*Q(-x)`，分母仅含偶次。新 P 取 U 中与 `n&1` 同奇偶的系数，新 Q 取 V 偶次项，再 `n>>=1`；n=0 返回 `P[0]/Q[0]`。

令 `d=max(deg(P),deg(Q))+1`，时间 $O(d log d log(n+1))$，工作空间 $O(d)$，每轮卷积须满足 NTT 长度上限。

*递推入口*　`recurrenceNth(initial,c,n)` 对 `a[t]=sum(c[i-1]*a[t-i])` 构造 `Q=1-c0*x-...-c[k-1]*x^k`，分子
$ P=(Q sum_(t=0)^(k-1)a_t x^t) mod x^k. $
初值至少 k 项，c 非空，末尾零系数允许。BM 返回空递推时按全零后续单独处理。

前缀和改分母为 `Q*(1-x)`；非齐次项先写相应生成函数并通分。分子通常不是初值数组本身，例如斐波那契初值 0、1 对应 P=x。不同下标分别调用会重复整段折半过程。

题目：#link("https://judge.yosupo.jp/problem/kth_term_of_linearly_recurrent_sequence")[Kth Term of Linearly Recurrent Sequence]。

#code("线性递推/线性递推第 n 项（Bostan-Mori）/Bostan-Mori.cpp", mode: "full")

参见 #link(<book-matrix-power>)[已知有限状态转移的矩阵快速幂]。

参见 #link(<book-poly-base>)[递推求项需要的多项式乘法]。

#pagebreak()


]
