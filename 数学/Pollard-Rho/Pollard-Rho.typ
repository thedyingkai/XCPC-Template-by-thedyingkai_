`isPrime(n)` 用确定性 Miller--Rabin 判断正 `i64` 范围内的整数是否为质数；当前七个测试底数覆盖整个 64 位范围，不能随意删减。`factor(n)` 对 `n>1` 反复用 Pollard--Rho 找非平凡因子，再递归到质数，返回 `map<质因子,指数>`。负数应先单独记录符号，`0` 和 `1` 必须按题意特判。

Miller--Rabin 把 $n-1=d 2^s$，检查随机底数的幂是否能经过平方到达 $-1$；合数若通过一次只是假素数候选，多组确定性底数共同排除。Pollard--Rho 在模 $n$ 的伪随机序列中寻找两项差与 $n$ 的非平凡公因子，碰到整因子 $n$ 时重新选择参数，因此运行时间有随机波动。大量接近上界的半素数需要更稳的常数时，可改用 Brent 判环和批量 `gcd`，但不要改变 Miller--Rabin 的覆盖范围。

#link("https://judge.yosupo.jp/problem/primality_test")[Library Checker · primality_test]

#link("https://judge.yosupo.jp/problem/factorize")[Library Checker · factorize]
