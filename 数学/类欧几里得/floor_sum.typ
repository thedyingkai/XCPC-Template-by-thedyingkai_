`floorSum(n,m,a,b)` 求 $sum_(i=0)^(n-1) floor((a i+b)/m)$，可直接表示直线下整点数、周期计数和等差分子整除和。要求 `n>=0`、`m>0`，`a,b` 可以为负数；参数、中间乘法和返回值均为 `i128`。题目若求 `i=0..n`，首参传 `n+1`；区间 `L..R` 用两个前缀相减。

算法先把 $a,b$ 中整除 $m$ 的部分拆成等差和，剩余部分满足 $0<=a,b<m$；随后交换横纵方向，把新的项数缩成 `floor((an+b)/m)`，这与欧几里得算法同阶。C++ 的负数除法向零截断，所以公开接口必须先用数学意义的向下取整规范化，不能删掉 `floorDiv`。返回精确值的前提是所有中间量可装入 `i128`。

#link("https://judge.yosupo.jp/problem/sum_of_floor_of_linear")[Library Checker · sum_of_floor_of_linear]
