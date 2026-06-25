设 $a, m$ 为正整数，

- 若 $b >= phi(m)$，则 $a^b equiv a^(b mod phi(m) + phi(m)) \(mod m\)$
- 若 $b < phi(m)$，直接计算 $a^b \(mod m\)$。

用途：当 $gcd(a,m) != 1$ 且指数很大时降幂。

时间复杂度：$O(sqrt(m))$ 求 $phi(m)$，快速幂 $O(log m)$。
