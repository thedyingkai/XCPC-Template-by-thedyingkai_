==== 从递推到目标项

`bostanMori(P,Q,n)` 求形式幂级数 $P(x)/Q(x)$ 的第 $n$ 项，要求 `Q[0] != 0` 且 `deg(P) < deg(Q)`。把分母乘 $Q(-x)$ 后只剩偶次项，而分子按 $n$ 的奇偶保留对应次数；下标每轮减半，目标系数不变，所以用 $O(log n)$ 轮多项式乘法即可得到答案，复杂度为 $O(k log k log n)$。

已知递推 $a_t=sum_(i=1)^k c_(i-1)a_(t-i)$ 时，`recurrenceNth(initial,c,n)` 构造 $Q=1-c_0x-...-c_(k-1)x^k$，并用前 $k$ 项确定低次分子。初值至少给 $k$ 项，系数模数固定为 `998244353`，下标从零开始。未知递推可先用 Berlekamp--Massey 从足够长的前缀恢复；含常数或低次多项式的非齐次递推，应扩状态或先推导相应生成函数。

#link("https://judge.yosupo.jp/problem/kth_term_of_linearly_recurrent_sequence")[Library Checker · kth_term_of_linearly_recurrent_sequence]
