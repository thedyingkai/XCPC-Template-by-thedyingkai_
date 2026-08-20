`SubsetConvolution::multiply(a,b)` 计算 $c[S]=sum_(A union B=S,A inter B=emptyset)a[A]b[B]$，即把每个集合拆成两个不交部分的加权和。算法按集合大小分层做子集 zeta，逐层卷积后再 Möbius 反演；集合大小保证交叠产生的项不会落入目标层，复杂度 $O(k^2 2^k)$、空间 $O(k 2^k)$。

输入长度必须相同且为二的幂。若允许 $A,B$ 相交，问题变成 OR 卷积，不能继续使用这一定义；$k$ 较小时直接枚举 `A` 的 $O(3^k)$ 写法通常更省代码。

#link("https://judge.yosupo.jp/problem/subset_convolution")[Library Checker · subset_convolution]
