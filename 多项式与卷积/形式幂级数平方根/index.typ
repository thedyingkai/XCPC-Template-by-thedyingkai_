#let render(code) = [
#heading(level: 2, outlined: true)[形式幂级数平方根] <book-poly-sqrt>

`poly998::squareRoot(f,n)` 求一种满足 $g^2 equiv f$ 模 $x^n$ 的根，返回 `optional`，无解为 `nullopt`。时间 $O(n log n)$，模数 `998244353`。

*先判首项*　只看低 `n` 项，若全零则返回全零；最低非零项 `c*x^d` 必须满足 `d` 为偶数、`c` 为二次剩余。令 `d=2t`，提出 `x^t`，剩余问题为非零常数项的平方根。

常数根用 Tonelli–Shanks，固定选两个模根中较小者。之后从该根开始倍增：
$ q_("new")=(q+h/q)/2. $
分母 `q` 常数非零，2 在奇质数模下可逆。每轮误差次数翻倍，截到当前精度。

调用后先判是否有值。常数项非零时，整体取负可换另一根；存在前导零时，高次项可能不受截断条件约束，代码把自由项置零，仅返回一种解。

题目：#link("https://judge.yosupo.jp/problem/sqrt_of_formal_power_series")[FPS Sqrt]。

#code("多项式与卷积/形式幂级数平方根/多项式平方根.cpp", mode: "full")


]
