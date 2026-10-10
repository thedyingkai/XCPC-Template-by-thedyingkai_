#import "裴蜀：任意整数线性组合只差 gcd/index.typ" as section-0
#import "不定方程：所有解变一个参数/index.typ" as section-1

#let render(code) = [
#heading(level: 3, outlined: true)[求 $a x + b y = c$ 的解] <book-variant-143>

`exgcd(a,b,x,y)` 求 `a*x+b*y=gcd(a,b)` 的贝祖系数，时间为对数量级。令 `g=gcd(a,b)`，方程 `a*x+b*y=c` 有整数解当且仅当 `g` 整除 `c`。

将贝祖系数乘 `c/g` 得特解 `(x0,y0)`，全部解：
$ x=x_0+k(b/g), quad y=y_0-k(a/g). $
当前主程序为 P5656：先读 T，再读正整数 a、b、c，输出正整数解范围。a、b 为正时，正解要求
$ ceil((1-x_0)/(b/g))<=k<=floor((y_0-1)/(a/g)). $
非负解把边界 1 改 0；有负输入须用数学 `floor_div/ceil_div` 并按系数符号推界。

同余 `a*x≡c (mod m)` 取第二系数 m，判整除后将特解规范到模 `m/g`。放大系数和回代可能溢出时，x、y 与中间量一起改 `i128`。

#code("数论/整数线性方程（扩展欧几里得）/求 a x + b y = c 的解/扩展欧几里得.cpp", mode: "full", ignore-main: false)


#section-0.render(code)

#section-1.render(code)

]
