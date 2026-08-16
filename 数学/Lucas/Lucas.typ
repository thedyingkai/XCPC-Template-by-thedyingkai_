Lucas 定理要求 $p$ 为质数。先调用 `lucas.init(p)`，再用相同的 $p$ 调用 `lucas.C(n,m,p)`。

- 当前预处理为 $O(p log p)$、空间 $O(p)$；$p$ 很大时不能直接套用。
- 合数模数需改用扩展 Lucas 或按质因子分解处理。

==== 板子题

- 洛谷 P3807「Lucas 定理」。
