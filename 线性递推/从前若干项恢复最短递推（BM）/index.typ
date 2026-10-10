#let render(code) = [
#heading(level: 2, outlined: true)[从前若干项恢复最短递推（BM）] <book-bm>

`berlekampMassey(sequence)` 从质数模序列前缀恢复最短相容递推，返回 c：
$ a_n=sum_(i=1)^k c_(i-1)a_(n-i). $
长度 N 的样本耗时 $O(N^2)$、空间 $O(N)$；全零序列返回空递推。

*使用前提*　答案须有固定系数线性递推。固定 D 阶线性状态转移保证阶数至多 D，前 `2D` 项足够；未知上界时，多采样和额外验证只能检验已给前缀。

`nth(initial,c,n)` 求 0 下标项，初值至少 k 项，时间 $O(k^2 log n)$。已知递推可直接调用，阶数大时换 Bostan–Mori；多传的初值须与递推一致，已提供下标会直接返回原初值。

*系数方向*　内部关系为 `a[n]+C1*a[n-1]+...=0`，输出取负。第 n 项差值 delta 非零时，修正 `C-=delta/last*x^shift*B`；若 `2L<=n`，阶数改为 `n+1-L`。不要仅因末尾系数零就缩短初值段。

远项将 `x^n` 模特征式 `x^k-c0*x^(k-1)-...-c[k-1]`，余数系数与前 k 项点乘。前缀和可另恢复递推，或给生成函数乘 `1/(1-x)`；换模数后重新恢复。

题目：#link("https://judge.yosupo.jp/problem/find_linear_recurrence")[Find Linear Recurrence]。

#code("线性递推/从前若干项恢复最短递推（BM）/Berlekamp-Massey.cpp")


]
