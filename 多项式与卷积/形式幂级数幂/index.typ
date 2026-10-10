#let render(code) = [
#heading(level: 2, outlined: true)[形式幂级数幂] <book-poly-power>

`polynomialPower(f,k,n)` 求 $f^k mod x^n$，`k` 为非负 `i64` 或十进制字符串，返回固定 `n` 项。`k=0` 返回常数 1，含零多项式的零次幂；正指数下零多项式返回全零。

*处理首项*　写 `f=x^t*c*h`、`h[0]=1`：
$ f^k=x^(t k)c^k exp(k ln h). $
若 `t*k>=n` 直接全零，否则计算归一化幂并平移。首项系数 `c` 在模意义下非零。

*大指数的三种量*　比较平移 `t*k` 用真实指数的截断值；乘对数系数用 `k mod p`；算 `c^k` 用 `k mod (p-1)`。三者分别处理，平移不能先取模。

多项式部分 $O(n log n)$，字符串指数另加位数扫描；找首项还需扫描输入，超长输入可先截到 `n`。负整数幂须常数项非零，先求逆再取正幂。

题目：#link("https://judge.yosupo.jp/problem/pow_of_formal_power_series")[FPS Pow]。

#code("多项式与卷积/形式幂级数幂/多项式幂.cpp", mode: "full")


]
