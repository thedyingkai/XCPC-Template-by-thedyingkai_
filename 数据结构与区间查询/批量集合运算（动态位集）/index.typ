#import "二维 0／1 关系压成 bitset/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[批量集合运算（动态位集）] <book-bitset>

运行时确定长度的位集，每个 `u64` 存 64 位。适合 01 背包可达性和按位并行转移；长度固定时可用 `std::bitset<N>`。

- `DynamicBitset(size)`：有效位 `0..size-1`，初始全零。
- `set(x)` 置 1，`test(x)` 查询，均为 $O(1)$；`clear()` 清空，`count()` 统计 1 的个数。
- `a |= b` 要求长度相等；`shiftOr(w)` 原地执行 `a |= a << w`，要求 `w>=0`。这些整块操作均为 $O(ceil("size"/64))$，空间同阶。

*背包*　容量为 `V` 时开 `V+1` 位，先 `set(0)`，每件物品调用一次 `shiftOr(w)`。从高字向低字更新，防止重复选同一件；移出范围的位丢弃。多重背包先二进制拆分。

*传递闭包*　枚举中间点 `k`，若 `reach[i].test(k)`，执行 `reach[i] |= reach[k]`。LCS 的位并行式还需跨字借位，当前接口没有实现减法。

题目：CSES 1745「Money Sums」。

#code("数据结构与区间查询/批量集合运算（动态位集）/动态位集.cpp")


#section-0.render(code)

]
