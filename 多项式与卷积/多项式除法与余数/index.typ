#let render(code) = [
#heading(level: 2, outlined: true)[多项式除法与余数] <book-poly-div>

`divideWithRemainder(A,B)` 求 `A=B*Q+R`、`deg(R)<deg(B)`；除式非零。`divide` 只取商，`modulo` 只取余数，结果去掉尾零，零多项式用空数组。

设次数 `n=deg(A),m=deg(B)`，`n>=m` 时商长 `n-m+1`。反转后：
$ Q^*=A^* (B^*)^(-1) mod x^(n-m+1). $
求得后反转回商，再算 `R=A-B*Q`。要求可逆的是原除式最高项，原常数项允许为 0。时间 $O(N log N)$，`N` 为输入规模。

`deg(A)<deg(B)` 时商零、余数 A；常数除式余数零。输出需固定长度时自行补零，访问结果下标前先判空。

*区分截断除法*　求 `A/B mod x^k` 时用 `multiply(A,inverse(B,k),k)`，要求 `B[0]!=0`。线性递推算 `x^k mod C(x)` 用整式余数，不能替换为仅保留低 `deg(C)` 项。

题目：#link("https://judge.yosupo.jp/problem/division_of_polynomials")[Division of Polynomials]。

#code("多项式与卷积/多项式除法与余数/多项式除法.cpp", mode: "full")


]
