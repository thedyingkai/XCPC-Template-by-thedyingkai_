`divideWithRemainder(A,B)` 求唯一的 $Q,R$，使 $A=B Q+R$ 且 $deg R<deg B$；除式必须非零。把两个多项式反转后，商的高次部分转成形式幂级数除法，因此可以用求逆和 NTT 在 $O(n log n)$ 内得到商，再回代求余数。`divide`、`modulo` 分别只返回其中一项，结果会删去末尾零系数。

这里反转后要求可逆的是原除式的最高次项，所以原常数项可以为零。形式幂级数的截断除法是另一件事：只求 $A/B mod x^n$ 时应计算 `multiply(A,inverse(B,n),n)`，并要求 `B[0] != 0`。线性递推的特征多项式取模和乘积树多点求值使用的是本文件的整式余数。

#link("https://judge.yosupo.jp/problem/division_of_polynomials")[Library Checker · division_of_polynomials]
