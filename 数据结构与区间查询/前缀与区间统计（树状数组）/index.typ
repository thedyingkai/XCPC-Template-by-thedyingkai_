#import "区间中某一位为 1 的个数/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[前缀与区间统计（树状数组）] <book-fenwick>

单点加、前缀和均为 $O(log n)$，空间 $O(n)$。下标从 1 开始，`update(x,k)` 加值，`query(x)` 求 `[1,x]`；区间和为 `query(r)-query(l-1)`。更新下标须大于 0。

*常用改法*

- 区间加、单点查：差分 `d[l]+=k`，若 `r<n` 则 `d[r+1]-=k`；前缀和还原当前值。
- 区间加、区间和：差分位置 `p` 向 `B1` 加 `d`，向 `B2` 加 `d*(p-1)`；数组前缀和为 `x*sum(B1,x)-sum(B2,x)`。
- 频率第 $k$ 小：沿二进制位试跳，找前缀和首次达到 `k` 的位置；频率须非负，且 `1<=k<=总频率`。

`countInv(n,a)` 接收有占位的 `a[1..n]`，内部离散化，统计严格逆序对，不改原数组。扫描时贡献为已加入数量减去小于等于当前值的数量。答案及乘积按范围选 `i64/i128`。

题目：P3374、P1908；#link("https://judge.yosupo.jp/problem/point_add_range_sum")[Point Add Range Sum] 的半开区间需转换。

#code("数据结构与区间查询/前缀与区间统计（树状数组）/树状数组.cpp", mode: "full", ignore-main: false)


#section-0.render(code)

]
