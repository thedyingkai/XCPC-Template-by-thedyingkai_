`Matrix<T,Mod>` 保存矩阵并提供乘法和非负整数次幂，适合普通矩阵乘法以及把固定线性状态转移推进到第 $k$ 步。整数 `T` 的所有运算按模板参数 `Mod` 取模，例如 `Matrix<i64,998244353>`；浮点 `T` 则直接计算。构造时维数必须非负，乘法要求左矩阵列数等于右矩阵行数，`Matrix::qp(A,k)` 要求方阵且 `k >= 0`。

直接读入或用下标赋值时不会立刻规范化，但参与运算后会归一到 `0..Mod-1`。整数版本最好令 `T=i64`；若 `Mod` 可能超过目标元素类型的正数范围，必须同步换宽 `T`。矩阵幂返回单位矩阵作为零次幂。初始状态是列向量 $v$、一步转移是 $A$ 时，第 $k$ 步写成 $A^k v$；含常数的仿射转移可增加一个恒为 $1$ 的坐标。

#link("https://judge.yosupo.jp/problem/matrix_product")[Library Checker · matrix_product]

#link("https://judge.yosupo.jp/problem/pow_of_matrix")[Library Checker · pow_of_matrix]
