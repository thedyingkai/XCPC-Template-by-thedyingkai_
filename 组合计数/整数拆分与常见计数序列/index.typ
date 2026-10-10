#import "正整数有序拆分/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[整数拆分与常见计数序列] <book-combinatorial-numbers>

`CombinatorialNumbers cn; cn.init(n,mod);` 预处理常见计数，时间、空间 $O(n^2)$，正模数可为合数。答案从 cn 的对应数组读取；仅需整数拆分时 `partitionNumbers(n,mod)` 为 $O(n sqrt n)$ 时间、$O(n)$ 空间。

*卡特兰*　`catalan[n]`，`C0=1`，合法括号、二叉树形态：
$ C_n=sum_(i=0)^(n-1)C_i C_(n-1-i)=binom(2n,n)-binom(2n,n-1). $
当前用卷积递推，合数模下无需除 `n+1`。

*错排*　`derangement[n]`，`D0=1,D1=0`，$D_n=(n-1)(D_(n-1)+D_(n-2))$。

*斯特林与贝尔*

- 第二类 `stirlingSecond[n][k]`：n 个有标号元素分 k 个非空无标号集合，$S_2(n,k)=S_2(n-1,k-1)+k S_2(n-1,k)$。满射数 `k!*S2(n,k)`，`bell[n]` 为 `sum_k S2(n,k)`。
- 无符号第一类 `stirlingFirst[n][k]`：n 元排列有 k 个环，$S_1(n,k)=S_1(n-1,k-1)+(n-1)S_1(n-1,k)$；有符号版本乘 $(-1)^(n-k)$。

*欧拉数*　`eulerian[n][k]` 为恰有 k 个下降位置的排列数：
$ A(n,k)=(n-k)A(n-1,k-1)+(k+1)A(n-1,k). $

*无序正整数拆分*　恰 k 份有 `p(n,k)=p(n-1,k-1)+p(n-k,k)`。当前 `partition[n]` 存总数，`p(0)=1`，负下标为 0，五边形递推
$ p(n)=sum_(k>=1)(-1)^(k-1)(p(n-k(3k-1)/2)+p(n-k(3k+1)/2)). $

选型先核对元素、盒子是否有标号以及能否为空。单问满射也可用 $sum_(i=0)^k(-1)^i binom(k,i)(k-i)^n$。

#code("组合计数/整数拆分与常见计数序列/组合计数.cpp", parts: ("partition-numbers", "common-numbers"))


#section-0.render(code)

]
