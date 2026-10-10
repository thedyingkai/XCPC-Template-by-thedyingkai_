#let render(code) = [
#heading(level: 2, outlined: true)[形式幂级数对数与指数] <book-poly-log-exp>

`logarithm(f,n)` 求 $ln f mod x^n$，要求 `f[0]==1`；`exponential(f,n)` 求 $exp(f) mod x^n$，要求常数项 0。均返回恰好 `n` 项，目标非负且在基础 NTT 范围内，时间 $O(n log n)$。

*公式*　对数用 $ln f=integral(f'/f)$，积分常数取 0。指数从 `g=1` 起，每轮倍增：
$ g_("new")=g(1+f-ln g) mod x^(2m). $
旧精度 `m` 下 `f-ln g` 的低项为 0，高阶误差截去即可。

*常用转换*

- `A'=H*A,A(0)=1`：先积分 H，再求指数。
- `f[0]=1` 时 `f^k=exp(k*ln(f))`；一般首项调用多项式幂接口。
- $F=product_j (1-x^j)^(-c_j)$ 时，$[x^k]ln F=(sum_(j divides k)j c_j)/k$；枚举倍数得到对数，再求指数。

形式运算中的分母用模逆元，积分所需整数须可逆。EGF 数组存 `a[i]/i!`，取计数乘回阶乘；OGF 不乘。输入远长于目标时先截到所需精度，避免额外扫描。

题目：#link("https://judge.yosupo.jp/problem/log_of_formal_power_series")[FPS Log]、#link("https://judge.yosupo.jp/problem/exp_of_formal_power_series")[FPS Exp]。

#code("多项式与卷积/形式幂级数对数与指数/多项式对数与指数.cpp", mode: "full")


]
