`exbsgs(a,b,p)` 求最小非负整数 $x$，使 $a^x equiv b \(mod p\)$；`a` 与 `p` 不要求互质，无解返回 `-1`，要求 `p > 0`。算法先逐次约去 $gcd(a,p)$：若该公因子不整除当前右端则立即无解，同时记录已经消耗的指数；剩余模数与底数互质后，再用 BSGS 在 $O(sqrt(p))$ 时间和空间内相遇。

$b equiv 1$ 对应零次幂，必须在约因子前保留这个答案。哈希表被构造数据卡常时可换自定义哈希；模数大到 `sqrt(p)` 的表无法承受时，这份算法本身就不适用，不能只调大内存。

#link("https://judge.yosupo.jp/problem/discrete_logarithm_mod")[Library Checker · discrete_logarithm_mod]
