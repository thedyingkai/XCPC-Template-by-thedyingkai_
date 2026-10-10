#let render(code) = [
#heading(level: 3, outlined: true)[floor_sum] <book-variant-158>

`floorSum(n,m,a,b)` 求
$ sum_(i=0)^(n-1) floor((a i+b)/m). $
要求 `n>=0,m>0`，a、b 可负；参数、返回值与中间量为 `i128`，须保证不溢出。

求 `i=0..n` 传 `n+1`；求 `L..R` 用两个前缀相减。直线下整点、等差分子整除和可直接对应这四个参数。

先拆 a、b 的整数商，累加等差贡献；余数规范到 `[0,m)` 后交换横纵方向，迭代次数与欧几里得同阶。负参数必须保留 `floorDiv` 的数学下取整，不能用 C++ 向零除法替代。

题目：#link("https://judge.yosupo.jp/problem/sum_of_floor_of_linear")[Sum of Floor of Linear]。

#code("数论/线性取整求和（类欧几里得）/floor_sum/floor_sum.cpp", mode: "full")


]
