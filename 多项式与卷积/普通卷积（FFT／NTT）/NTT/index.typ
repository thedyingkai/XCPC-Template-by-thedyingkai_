#let render(code) = [
#heading(level: 3, outlined: true)[NTT] <book-ntt>

模 `998244353` 的精确卷积。`NTT::multiply(A,B)` 输入和输出为 *1 下标*，数学系数 a[i] 存 A[i+1]；空多项式用仅含占位 0 的数组。结果有效段 `1..n+m-1`。

底层 `ntt` 使用无占位的 0 下标数组，长度 L 须为二次幂且 `L<=2^23`；负系数会规范化。普通卷积需 `L>=n+m-1`，时间 $O(L log L)$、空间 $O(L)$。长度不足将得到模 `x^L-1` 的循环卷积。

原根 3，单位根 `3^((p-1)/L)`；逆变换换逆根、最后乘 `inv(L)`。改模数须同时确认原根和 `L|(p-1)`。完整 FPS 运算使用多项式目录的 0 下标接口。

*精确或任意模卷积*　单模结果仅为余数。CRT 模数乘积须覆盖真实系数：非负输入上界 A、B 时，每项至多 `min(n,m)*A*B`；有符号对称恢复需超过两倍绝对值上界。每个模数都须支持 L，重构与乘法同步扩宽。

题目：#link("https://judge.yosupo.jp/problem/convolution_mod")[Convolution Mod]。

#code("多项式与卷积/普通卷积（FFT／NTT）/NTT/NTT.cpp", mode: "full", ignore-main: false)


]
