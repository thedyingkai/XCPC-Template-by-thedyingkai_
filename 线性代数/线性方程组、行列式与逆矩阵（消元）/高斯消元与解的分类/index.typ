#let render(code) = [
#heading(level: 3, outlined: true)[高斯消元与解的分类] <book-gauss>

`A.Gauss(&aug,&w)` 原地化为简化行阶梯形，返回秩，`w[c]` 记录主元列 c 所在行。aug 行数与 A 一致，可含多列右端，每列都要单独判解。

*结果判定*　某行系数全零而右端非零则无解；无矛盾、秩小于未知数数目则有自由元；满列秩才唯一。整数版本用质数模的费马逆元；浮点版选绝对值最大主元，绝对零阈值为 `1e-12`。

*特解与解空间*　所有自由变量设 0，主元列 c 的特解为 `aug[w[c]][0]`。对每个自由列 f 建基向量：该自由项为 1，其他自由项为 0，各主元项为 `-A[w[c]][f]`，模域中规范化。m 未知量、秩 r 时共有 m−r 个基向量，有限域解数 $p^(m-r)$。

*附加用途*　单位矩阵作多列右端可求逆。行列式须记录交换符号及归一化前主元，不能乘消元后的单位主元。异或方程改位集上的 $F_2$ 消元。

n 方程、m 未知量、q 列右端，时间 $O(n min(n,m)(m+q))$，方阵单右端为 $O(n^3)$。需残差验证时先留原矩阵；尺度悬殊可按行缩放。`solveLinear` 只返回唯一解，多解输出用此处构造。

题目：#link("https://judge.yosupo.jp/problem/matrix_rank")[Matrix Rank]、#link("https://judge.yosupo.jp/problem/system_of_linear_equations")[System of Linear Equations]。

#code("线性代数/线性方程组、行列式与逆矩阵（消元）/高斯消元与解的分类/高斯消元.cpp", mode: "full")


]
