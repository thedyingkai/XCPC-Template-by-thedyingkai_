#let render(code) = [
#heading(level: 3, outlined: true)[快速乘] <book-variant-140>

`b_mul(a,b,p)` 求任意有符号 `i64` 的 `a*b mod p`，要求 `p>0`，返回 `[0,p)`。先转 `i128` 再乘、取模，单次常数时间；需要编译器支持 `__int128`。

#code("数论/模幂与防溢出模乘/快速乘/快速乘.cpp", mode: "full")


]
