`logarithm(f,n)` 求 $ln f(x) mod x^n$，要求 `f[0]==1`；它使用 $ln f=integral(f'/f)$。`exponential(f,n)` 求 $exp f(x) mod x^n$，要求常数项为零，并用 Newton 迭代令当前答案乘上 $1+f-ln g$。两者均返回恰好 $n$ 项，复杂度 $O(n log n)$。

这些常数项条件决定形式幂级数解是否按当前定义唯一，不能靠给所有系数整体平移来“修补”。多项式幂在常数项为一时可写成 $exp(k ln f)$；含前导零或任意非零首项时还要单独处理次数平移和首项的幂，直接调用下一份封装更稳。

#link("https://judge.yosupo.jp/problem/log_of_formal_power_series")[Library Checker · log_of_formal_power_series]

#link("https://judge.yosupo.jp/problem/exp_of_formal_power_series")[Library Checker · exp_of_formal_power_series]
