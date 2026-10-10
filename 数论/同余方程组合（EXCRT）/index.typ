#import "非互质同余合并/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[同余方程组合（EXCRT）] <book-excrt>

`excrt(m,r,n)` 合并 `x≡r[i] (mod m[i])`，数组用 `1..n`，模数正且不要求互质。有解返回最小非负解，无解 −1；余数会规范化。

当前解 `x=r1+m1*t` 与新条件合并为 `m1*t≡r2-r1 (mod m2)`。令 `g=gcd(m1,m2)`，差不被 g 整除则矛盾；否则 exgcd 求约去 g 的 t，新周期为 `lcm(m1,m2)`。

中间乘法用 `i128`，最终周期仍须装入 `i64`，超出抛 `overflow_error`。更大范围须同步扩返回值、周期和相关运算。

若要求最小 `x>=L`，另保留最终周期 M，取 `r+ceil((L-r)/M)*M`，上取整按数学定义。n 条合并，每次为一次欧几里得量级。

题目：P4777。

#code("数论/同余方程组合（EXCRT）/EXCRT.cpp", mode: "full")


#section-0.render(code)

]
