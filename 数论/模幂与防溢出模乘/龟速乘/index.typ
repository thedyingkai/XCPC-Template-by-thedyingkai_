#let render(code) = [
#heading(level: 3, outlined: true)[龟速乘] <book-variant-141>

`s_mul(a,b,p)` 求 `a*b mod p`，接受任意有符号 `i64` 的 a、b，要求 `p>0`，返回 `[0,p)`。先归一化，再二进制倍增，时间 $O(log p)$。

`add_mod` 用比较与相减规避 `x+y` 溢出，保留这套加法；负数归一化不使用 `abs`，以支持 `LLONG_MIN`。有 `i128` 时可直接选宽整数快速乘。

#code("数论/模幂与防溢出模乘/龟速乘/龟速乘.cpp", mode: "full")


]
