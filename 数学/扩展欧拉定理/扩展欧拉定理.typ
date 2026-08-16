`exEulerPow(a,b,m)` 计算 $a^b mod m$，其中 `b` 是非负十进制字符串，要求 $m>0$。

- `depow` 同时计算 $b mod phi(m)$ 并判断 $b>=phi(m)$；不能无条件给指数加 $phi(m)$，尤其注意 $b=0$。
- 已知 $gcd(a,m)=1$ 时可直接取模 $phi(m)$；当前试除求 $phi(m)$ 的复杂度为 $O(sqrt(m))$。

==== 板子题

- 洛谷 P5091「扩展欧拉定理」。
