==== 用途

- `exbsgs(a,b,p)` 求 $a^x equiv b \(mod p\)$ 的最小非负整数解，`a` 与 `p` 不必互质；要求 `p>0`，无解返回 `-1`，复杂度和空间均为 $O(sqrt(p))$ 量级。

- 数据卡 `unordered_map` 时换自定义哈希。

==== 板子题

- 洛谷 P4195「扩展 BSGS」。
