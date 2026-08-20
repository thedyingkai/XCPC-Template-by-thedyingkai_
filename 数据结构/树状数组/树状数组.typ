树状数组把每个位置负责的长度设为 `lowbit(x)`，用 $O(log n)$ 个节点维护前缀和。`update(x,k)` 单点增加，`query(x)` 查询 `[1,x]`；区间和由两个前缀相减，差分、频率统计和逆序对也都能化成这两个接口。

下标从 `1` 开始。`countInv(n,a)` 要求 `a` 为 `1` 下标，统计严格逆序对；重复值不计，原数组不会被修改。

- 区间加、单点查：在差分位置 `l` 加 `k`、`r+1` 减 `k`。
- 区间加、区间和：维护 `B1,B2`，前缀和为 `x*sum(B1)-sum(B2)`；差分位置 `p` 分别加 `d` 和 `d*(p-1)`。
- 频率前缀第 $k$ 小可按最高二进制位向下跳；频率必须非负。
- 逆序对先离散化；当前元素贡献为“已加入数量减去小于等于它的数量”。

- 洛谷 P3374「树状数组 1」；P1908「逆序对」可直接调用 `countInv`。
- #link("https://judge.yosupo.jp/problem/point_add_range_sum")[Library Checker · Point Add Range Sum]
