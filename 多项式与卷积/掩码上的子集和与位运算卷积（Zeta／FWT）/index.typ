#import "SOS：每个集合的全部子集之和/index.typ" as section-0
#import "不相交查询取有限全集补集/index.typ" as section-1

#let render(code) = [
#heading(level: 2, outlined: true)[掩码上的子集和与位运算卷积（Zeta／FWT）] <book-subset-transform>

长度 `N=2^k` 的掩码数组，模数 `998244353`。OR、AND、XOR 卷积分别统计 `A|B=S`、`A&B=S`、`A^B=S` 的 `a[A]*b[B]` 之和；两侧选择有序，`a=b` 时仍包含同一对象配对。

*变换与卷积*

- `subsetZeta(a)`：变为所有子集和；参数 `true` 做逆变换。含位 `b` 的 `S` 从 `S^(1<<b)` 加入贡献，逆变换改减。
- `supersetZeta`：所有超集和，对称处理不含位 `b` 的状态。
- OR：子集 Zeta、逐点乘、逆变换。
- AND：超集 Zeta、逐点乘、逆变换。
- XOR：每对 `(x,y)` 变成 `(x+y,x-y)`；逆变换每层再乘 `inv2`。

输入两数组等长、为正二次幂，先补零覆盖全部掩码，长度 1 合法。变换原地修改，卷积接口复制输入。时间 $O(k 2^k)$；卷积额外空间 $O(2^k)$，原地变换常数辅助空间。

*选型边界*　OR 允许两集合重叠，要求不相交并集时用子集卷积。空集合 `mask=0` 可有非零权重；枚举全部子集 `T=(T-1)&S` 时另计 `T=0`，全体枚举为 $O(3^k)$。

OR、AND 逆变换只用加减；XOR 还要求 2 可逆，偶数模不可沿用。改模数同时检查乘法范围。自卷积求无序不同对象对时，按题意扣自配对并除以二。

题目：#link("https://judge.yosupo.jp/problem/bitwise_and_convolution")[AND Convolution]、#link("https://judge.yosupo.jp/problem/bitwise_xor_convolution")[XOR Convolution]。

#code("多项式与卷积/掩码上的子集和与位运算卷积（Zeta／FWT）/集合变换.cpp")


#section-0.render(code)

#section-1.render(code)

]
