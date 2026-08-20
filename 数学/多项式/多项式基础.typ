本组接口把系数按常数项到高次项的顺序放在零下标数组中，模数固定为 $998244353$。`multiply(a,b,need)` 求卷积，给出 `need` 时只保留前 `need` 项；`derivative` 和 `integral` 分别求形式导数与积分，积分常数固定为零。所有后续求逆、对数、指数、幂和多点求值都复用这里的 NTT。

形式幂级数只关心模 $x^n$ 的前 $n$ 项，所以尽早传截断长度可以避免无用计算。最大 NTT 长度为 $2^23$；积分需要 $1,2,...$ 的逆元，而当前可用长度远小于模数。更换模数时必须同时更换原根并核对长度，不能只改常量。单次卷积若使用外层 NTT 板，要注意它是 `1` 下标，不能与这里的数组直接混用。

#link("https://judge.yosupo.jp/problem/convolution_mod")[Library Checker · convolution_mod]
