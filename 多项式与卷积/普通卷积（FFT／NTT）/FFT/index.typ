#let render(code) = [
#heading(level: 3, outlined: true)[FFT] <book-fft>

`FFT::multiply(a,b)` 求整数系数卷积，输入和输出均为 *1 下标*，有效答案 `1..l1+l2-1`。变换长 L 为不小于系数总长减一的二次幂，时间 $O(L log L)$、空间 $O(L)$。

结果实部四舍五入后存 int。真实系数须装入 int，且浮点误差绝对值小于 1/2 才能恢复整数；扩大返回类型不会提高 double 精度。大系数可拆位卷积，要求精确时用 NTT/CRT。

*数字乘法*　低位放下标 1，卷积后 `get(ans,10)` 进位。get 仅支持非负系数、`2<=base<=10`，符号先拆。例如 12、34 输入 `{0,2,1}`、`{0,4,3}`。

*相关匹配*　求对齐内积时反转第二数组。数学 0 下标偏移 s、模式长 m，对应本接口 `result[s+m]`。按字符建 0/1 数组并累加，可统计每次对齐的匹配位数。

底层 fft 要求非空二次幂数组，multiply 负责补齐。当前正向单位根用正角，逆向用共轭并除 L；正反约定配套。长度不足会变循环卷积。

题目：#link("https://judge.yosupo.jp/problem/multiplication_of_big_integers")[Multiplication of Big Integers]。

#code("多项式与卷积/普通卷积（FFT／NTT）/FFT/FFT.cpp", mode: "full", ignore-main: false)


]
