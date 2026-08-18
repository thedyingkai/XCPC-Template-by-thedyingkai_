==== 用途

- 输入有理生成函数 $P(x)/Q(x)$ 和巨大下标 $n$，求第 $n$ 项系数；已知线性递推时可先转成该分式，再直接求远项。

==== 接口与边界

- `bostanMori(P,Q,n)` 求形式幂级数 $P/Q$ 的第 $n$ 项，要求 `Q[0]!=0` 且 `deg(P)<deg(Q)`，复杂度 $O(k log k log n)$。
- `recurrenceNth(initial,c,n)` 使用约定 $a_t=sum_(i=1)^k c_(i-1)a_(t-i)$；初值至少给前 $k$ 项。
- 系数模数固定为 `998244353`；`n` 使用 `u64`，递推阶数大时比 Berlekamp–Massey 文件中的 $O(k^2 log n)$ 求项更合适。

==== 改法与 trick

- 未知递推先用 Berlekamp–Massey 从足够多项中求 `c`，再交给 `recurrenceNth`。
- 递推含非齐次常数或多项式时，可扩状态转成齐次递推，或先写出生成函数的分子分母。

==== 板子题

- Library Checker「K-th Term of Linearly Recurrent Sequence」。
