#let render(code) = [
#heading(level: 2, outlined: true)[形式幂级数求逆] <book-poly-inverse>

`poly998::inverse(f,n)` 求 $f g equiv 1$ 模 $x^n$，目标 `n>=0`；正精度要求 `f[0]!=0`。返回恰好 `n` 项，输入缺少的高次项视为 0，时间 $O(n log n)$。

*牛顿倍增*　初值 `g[0]=inv(f[0])`，旧精度 `m` 扩为 `2m`：
$ g_("new")=g(2-f g) mod x^(2m). $
若 `fg=1-e`，新误差为 `e*e`。每轮卷积后截断到目标精度。

*卷积递推*　`f[0]=1`、`f[i]=sum(a[j]*f[i-j],j=1..i)` 时，令 `A` 常数项为 0，得 `F=1/(1-A)`；待求逆数组放 `{1,-a[1],-a[2],...}`。额外初始贡献为 `B` 时，求 `B/(1-A)`。

常数项 0 没有普通形式幂级数逆元；提出 `x^t` 后需另处理下标。改合数模时，常数项须与模数互质，费马逆元和 NTT 也须替换。

题目：#link("https://judge.yosupo.jp/problem/inv_of_formal_power_series")[FPS Inv]。

#code("多项式与卷积/形式幂级数求逆/多项式求逆.cpp", mode: "full")


]
