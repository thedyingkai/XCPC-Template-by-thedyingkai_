#import "组合选择替代复杂求和/index.typ" as section-0
#import "模小质数的组合数按位拆/index.typ" as section-1

#let render(code) = [
#heading(level: 3, outlined: true)[任意模数下的组合数] <book-variant-170>

`ArbitraryModComb` 先 `init(m)` 分解正模数，随后 `C(n,k)` 求组合数模 m。`m=1` 或 `k<0,k>n` 时返回 0；同模多问只初始化一次。

*规模限制*　对每个质数幂 `M=p^q` 整段预处理，时间、空间 $O(sum p^q)$，试除分解另耗 $O(sqrt(m))$。最大质数幂须能开表；质数模且 n 小于模数时，用普通阶乘更短。

*质数幂公式*　令 `e(n)=sum floor(n/p^j)`，去除所有 p 因子的阶乘为 U。组合数指数 `e=e(n)-e(k)-e(n-k)`：若 `e>=q` 为 0，否则
$ binom(n,k) equiv U(n)U(k)^(-1)U(n-k)^(-1)p^e. $
单位部分与 M 互质，才可求逆。

前缀 `H(t)` 为 `1..t` 中不被 p 整除的乘积，递推
$ U(n) equiv H(M)^(floor(n/M))H(n mod M)U(floor(n/p)). $
每个质数幂查询约 $O(log_p(n+1)log(n+1)+log M)$，最后 CRT 合并互质分量。

超大质数幂须换分块阶乘等算法。题目：P4720。

#code("组合计数/组合数计算/任意模数下的组合数/任意模组合数.cpp")


#section-0.render(code)

#section-1.render(code)

]
