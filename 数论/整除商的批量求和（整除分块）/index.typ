#import "整除分块：相同商一段算/index.typ" as section-0
#import "多个整除商同时相同/index.typ" as section-1
#import "取整区间反推分母范围/index.typ" as section-2

#let render(code) = [
#heading(level: 2, outlined: true)[整除商的批量求和（整除分块）] <book-division-block>

`floor(n/i)` 只有 $O(sqrt n)$ 种值。左端 l 的商 `q=n/l`，同商右端 `r=n/q`，处理后令 `l=r+1`；有多个商时取各自右端最小值。

对 `sum(f[d]*(n/d)*(m/d))`，扫至 `min(n,m)`，本段贡献
`(pre[r]-pre[l-1])*(n/l)*(m/l)`。
*代码的 `PRE()` 留空*，使用前填 `pre[i]=sum(f[1..i])`。互质数对用 mu，GCD 和用 phi，一般 `g(gcd)` 先求 `f=g*mu` 的狄利克雷卷积。

`n mod i=n-(n/i)*i` 可将余数和转成整除项与等差和。GCD 等于 k 时先除两上界，矩形计数做四次前缀容斥。乘法与答案可能超 `i64` 时先扩 `i128`。

题目：P2261、P1403。

#code("数论/整除商的批量求和（整除分块）/整除分块.cpp", mode: "full")


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

]
