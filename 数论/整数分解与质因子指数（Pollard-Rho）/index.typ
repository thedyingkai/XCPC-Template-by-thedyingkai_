#import "质因子指数取代巨大乘积/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[整数分解与质因子指数（Pollard-Rho）] <book-pollard-rho>

`PollardRho::isPrime(n)` 判质，`PollardRho::factor(n)` 返回 `map<质因子,指数>`。接口限正 i64 范围；factor 对 `n<=1` 返回空表，0、1、负号按题意处理。随附 main 仅输出 Prime 或最大质因子。

*判质*　Miller–Rabin 把 `n-1=d*2^s`，检查 `a^d` 是否为 1 或 −1，否则继续平方找 −1。当前七底数在接口范围内为确定性判定，保留完整集合；`a%n==0` 只跳过本轮。固定底数下需要 $O(log n)$ 次模乘。

*分解*　对已知合数迭代 `f(x)=x*x+c mod n`，Floyd 快慢指针求 `gcd(|x-y|,n)`：1 继续，严格介于 1 与 n 得因子，等于 n 则换参数重试。因子还可能合数，继续递归分解两侧。

最小质因子 p 的随机碰撞通常约 $O(sqrt p)$ 轮，单次找因子常按 $O(n^(1/4))$ 轮估计，另计 gcd、模乘、重试与递归；无固定最坏轮数。批量小范围数用最小质因子筛；大量大半素数可改 Brent 与批量 gcd。

乘法及平方加 c 在 i128 内计算。完整 u64 范围需统一无符号边界与 u128 模乘；负输入处理须避开 `abs(LLONG_MIN)`。

题目：#link("https://judge.yosupo.jp/problem/primality_test")[Primality Test]、#link("https://judge.yosupo.jp/problem/factorize")[Factorize]。

#code("数论/整数分解与质因子指数（Pollard-Rho）/Pollard-Rho.cpp", mode: "full", ignore-main: false)


#section-0.render(code)

]
