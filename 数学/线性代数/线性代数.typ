==== 行列式、逆矩阵与唯一解

`det()` 对方阵消元：交换两行会改变符号，主元乘积给出行列式；出现缺失主元即行列式为零。`inv()` 把单位矩阵作为增广部分同步消元，左侧能化为单位矩阵时，右侧就是逆矩阵；非方阵或不可逆时返回空矩阵。

`solveLinear(A,b)` 只在 $A x=b$ 有唯一解时返回 `{true,x}`，无解、多解以及右端长度不匹配都返回 `false`。需要区分无解与多解时直接调用 `Gauss`，分别检查矛盾行和秩。整数版本依赖质数模数下每个非零主元可逆；合数模数不是域，不能用这份除主元的消元求一般行列式或逆矩阵。

#link("https://judge.yosupo.jp/problem/matrix_det")[Library Checker · matrix_det]

#link("https://judge.yosupo.jp/problem/inverse_matrix")[Library Checker · inverse_matrix]
