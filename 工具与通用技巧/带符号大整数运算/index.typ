#let render(code) = [
#heading(level: 2, outlined: true)[带符号大整数运算] <book-bigint>

`Big` 为带符号整数，支持比较、流输入输出和 `+ - * / %`。`divmod(a,b)` 同时求商余，`b!=0`；商向零取整，余数与被除数同号，满足 `a=(a/b)*b+a%b`。

平时用 $10^9$ 进制存绝对值。短乘为竖式，长乘转 $10^4$ 进制做双模 NTT、CRT 恢复，再转回；加减按位数线性，长乘近似 $O(d log d)$，除法仍为二次量级。

*长乘上限*　第二模数最多 $2^21$ 点。十进制位数 `d1,d2` 须满足
`bit_ceil(ceil(d1/4)+ceil(d2/4)-1) <= (1u<<21)`。
等长时每数约最多 419 万位，超过需换模数或分块。

仅求模值可在读字符串时滚动取模；本类不表示小数。

题目：#link("https://judge.yosupo.jp/problem/addition_of_big_integers")[大整数加法]、#link("https://judge.yosupo.jp/problem/multiplication_of_big_integers")[大整数乘法]。

#code("工具与通用技巧/带符号大整数运算/高精度加减乘除取余.cpp")


]
