`poly998::squareRoot(f,n)` 求一种 $g(x)^2 equiv f(x) \(mod x^n\)$ 的解，无解返回 `nullopt`。最低非零项次数必须为偶数，且其系数必须是模 $998244353$ 的二次剩余；提出对应的 $x^(2t)$ 后，常数平方根由 Tonelli--Shanks 求得，其余项用 $g'=(g+f/g)/2$ 倍增。

零多项式返回全零。常数根固定取两个根中较小者，将整个结果取负仍是另一个根；最低非零次数大于零时可能还有由截断产生的其他根，本接口只返回固定一种。返回值只保证模 $x^n$ 意义下正确。

#link("https://judge.yosupo.jp/problem/sqrt_of_formal_power_series")[Library Checker · sqrt_of_formal_power_series]
