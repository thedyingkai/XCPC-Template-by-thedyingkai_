`polynomialPower(f,k,n)` 求 $f(x)^k mod x^n$，指数可传非负 `i64` 或非负十进制字符串。实现先找到最低非零项 $c x^t$：若 $t k>=n$，答案全零；否则提出 $x^(t k)c^k$，把剩余常数项归一成一，再计算 $exp(k ln f)$。这样能正确处理前导零、任意非零首项和零多项式，复杂度 $O(n log n)$。

字符串指数同时维护次数平移所需的截断值、模 $998244353$ 的系数倍数和模 $998244352$ 的首项指数，三者不能混成同一个余数。`k=0` 返回常数多项式一。有理指数只有在常数项和根的定义满足题意时才有意义，不能直接把参数类型换成分数。

#link("https://judge.yosupo.jp/problem/pow_of_formal_power_series")[Library Checker · pow_of_formal_power_series]
