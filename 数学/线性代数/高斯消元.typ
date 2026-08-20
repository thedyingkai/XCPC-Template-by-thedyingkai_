==== 方程组如何落到消元

把每条线性约束写成一行系数，右端常数放进增广矩阵；`Gauss` 原地化成简化行阶梯形并返回秩，`w[c]` 记录第 `c` 列主元所在行。给 `aug` 传入一列或多列右端项，可让它们和系数矩阵接受完全相同的行变换。正确性来自三种初等行变换不改变方程组解集，而每次只用一个新主元消去该列的其他项。

整数 `T` 按 `MOD` 用费马逆元，只能在质数模数的域上使用；浮点 `T` 按绝对值选主元并用误差判断零。消元后若某行系数全零而右端非零，则无解；无矛盾但秩小于未知数个数，则有自由元；只有秩等于未知数个数时才是唯一解。异或方程应把行换成 `bitset` 并在 $F_2$ 上消元，不要继续做普通乘除。

Library Checker 的线性方程组题还要求输出一个特解和齐次解空间的一组基。调用 `A.Gauss(&aug,&w)` 后，若无矛盾，令全部自由变量为零，主元列 `c` 的特解就是 `aug[w[c]][0]`。对每个自由列 `f` 再构造一个齐次基向量：令第 `f` 项为 `1`、其他自由项为 `0`，每个主元列 `c` 取 `-A[w[c]][f]` 并按模数规范化。当前 `solveLinear` 只返回唯一解；遇到多解时应按上面的 `w` 和消元后矩阵自行组织输出，不能直接调用它。

#link("https://judge.yosupo.jp/problem/matrix_rank")[Library Checker · matrix_rank]

#link("https://judge.yosupo.jp/problem/system_of_linear_equations")[Library Checker · system_of_linear_equations]
