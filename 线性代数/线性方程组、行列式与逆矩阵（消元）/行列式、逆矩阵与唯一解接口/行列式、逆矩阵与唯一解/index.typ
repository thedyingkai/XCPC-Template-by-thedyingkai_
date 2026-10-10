#let render(code) = [
#heading(level: 4, outlined: true, numbering: none)[行列式、逆矩阵与唯一解]

`det()` 求方阵行列式：交换行变号，乘归一化前主元；无主元则为 0。`inv()` 同步消元单位矩阵，非方阵或奇异时返回空矩阵。

`solveLinear(A,b)` 仅在唯一解时返回 `{true,x}`；无解、多解、右端长度错误均返回 false。要区分无解与多解，调用 `Gauss` 检查零行和秩。

方阵运算 $O(n^3)$，空间 $O(n^2)$。整数实现要求质数模；合数模非零主元未必可逆，须换消元方法。

题目：#link("https://judge.yosupo.jp/problem/matrix_det")[Matrix Determinant]、#link("https://judge.yosupo.jp/problem/inverse_matrix")[Inverse Matrix]。

#code("线性代数/线性方程组、行列式与逆矩阵（消元）/行列式、逆矩阵与唯一解接口/行列式、逆矩阵与唯一解/线性代数.cpp", parts: ("determinant", "inverse", "solve-linear"))

参见 #link(<book-matrix-tree>)[生成树计数的矩阵树定理]。

#pagebreak()


]
