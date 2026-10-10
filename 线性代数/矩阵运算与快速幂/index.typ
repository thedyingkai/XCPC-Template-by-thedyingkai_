#import "旧版矩阵快速幂接口/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[矩阵运算与快速幂] <book-matrix-power>

`Matrix<T,Mod>` 支持矩阵乘法和 `Matrix<T,Mod>::qp(A,k)`。维数非负，乘法内维一致；幂要求方阵、`k>=0`，零次幂返回单位矩阵。

整数 T 按 Mod 取模，常用 `Matrix<i64,998244353>`；浮点 T 直接计算。赋值、读入时暂不规范化，运算中归一到 `[0,Mod)`；Mod 的正值范围须能存入 T。

`n*m` 乘 `m*k` 时间 $O(n m k)$；d 阶幂 $O(d^3 log k)$，工作空间 $O(d^2)$。列状态 v 每步乘 A，第 k 步 `A^k*v`；带常数转移加恒为 1 的坐标。

题目：#link("https://judge.yosupo.jp/problem/matrix_product")[Matrix Product]、#link("https://judge.yosupo.jp/problem/pow_of_matrix")[Pow of Matrix]。

#code("线性代数/矩阵运算与快速幂/矩阵运算.cpp")


#section-0.render(code)

]
