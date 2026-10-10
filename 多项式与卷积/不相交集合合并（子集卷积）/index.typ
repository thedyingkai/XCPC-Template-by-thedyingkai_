#let render(code) = [
#heading(level: 2, outlined: true)[不相交集合合并（子集卷积）] <book-subset-convolution>

`SubsetConvolution::multiply(a,b)` 求
$ c[S]=sum_(A subset.eq S)a[A]b[S xor A]. $
即 `A,B` 不相交且并为 `S` 的有序划分。输入非空、等长，长度为 `2^k`；模数 `998244353`，负输入会归一化。

时间 $O(k^2 2^k)$，空间 $O(k 2^k)$。当前同时存三份 `i64` 分层数组，主体约 `24*(k+1)*2^k` 字节；*k=20 时约 504 MiB*，另加输入、返回值与容器。

*分层步骤*　将 `a[S]` 放第 `popcount(S)` 层，各层子集 Zeta；对固定 `S` 按层卷积 `C[t][S]=sum(A[i][S]*B[t-i][S])`；各层逆变换后取 `C[popcount(S)][S]`。逆变换保证并集恰为 S，大小相加保证不相交。

允许空部分保留 `a[0],b[0]`，要求两部分非空则置零。无标签划分须另处理交换重复。允许交叠用 OR 卷积；取最小值的划分用枚举子集等方法，当前逆变换依赖加减抵消。

小 `k` 可直接枚举所有子集，总 $O(3^k)$，记得包含空子集。题目：#link("https://judge.yosupo.jp/problem/subset_convolution")[Subset Convolution]。

#code("多项式与卷积/不相交集合合并（子集卷积）/子集卷积.cpp")


]
