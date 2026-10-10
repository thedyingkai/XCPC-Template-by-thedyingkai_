#let render(code) = [
#heading(level: 2, outlined: true)[多项式基础运算与 NTT 接口] <book-poly-base>

所有系数 0 下标、常数项在前，模数固定 `998244353`。`multiply(a,b,need)` 求卷积，给 `need` 时只保留前 `need` 项；`derivative` 求导，`integral` 积分常数为 0。

长度 `n` 表示最高次数 `n-1`；模 $x^n$ 表示只取低 `n` 项。求前 `n` 项导数需原式前 `n+1` 项。普通卷积第 `k` 项为 $sum_(i+j=k)a_i b_j$，适用于下标相加的贡献。

*长度限制*　最大 NTT 长度 $2^23$，普通卷积需 `bit_ceil(a.size()+b.size()-1)` 不超过它。即使输出截断，也须核对实际卷积长度。变换长度为 `N` 时，时间 $O(N log N)$、空间 $O(N)$。

积分需相应整数的逆元。改模数须同时核对原根、二次幂长度与逆元条件。本目录使用 0 下标；外层单独 NTT 模板采用 1 下标。

生成函数等式先化成运算或迭代式，再调用接口；含未知量的方程如 `F=1+x*F*F` 需解方程，不能只求一次右端。

题目：#link("https://judge.yosupo.jp/problem/convolution_mod")[Convolution Mod]。

#code("多项式与卷积/多项式基础运算与 NTT 接口/多项式基础.cpp", mode: "full")


]
