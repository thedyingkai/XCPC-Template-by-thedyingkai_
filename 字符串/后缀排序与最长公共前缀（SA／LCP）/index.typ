#let render(code) = [
#heading(level: 2, outlined: true)[后缀排序与最长公共前缀（SA／LCP）] <book-suffix-array>

确定性处理静态子串顺序与 LCP。当前倍增加计数排序，构造 $O(n log n)$、空间 $O(n)$；输入为字节串，整数序列须改类型并离散化初始排名。

`sa/rk/height` 全为 0 下标：`sa[i]` 是第 `i` 小后缀的起点，`rk[pos]` 是后缀排名，`height[i]=LCP(sa[i-1],sa[i])`，`height[0]=0`。

*LCP 查询*　另建 `height` 的 RMQ。若 `x!=y`，令 `a=min(rk[x],rk[y])`、`b=max(...)`，答案为 `min(height[a+1..b])`；同一起点返回 `n-x`。ST 表额外占 $O(n log n)$ 空间，查询 $O(1)$；线段树空间 $O(n)$，查询 $O(log n)$。

*常用公式与操作*

- 不同子串数：`n*(n+1)/2-sum(height)`，先扩到 `i64`。
- 最长重复子串：`max(height)`。至少出现 `k>=2` 次时，对连续 `k` 个后缀取内部 `k-1` 个 `height` 的最小值，再取最大；`k=1` 答案为 `n`。
- 第 $k$ 小不同子串：第 `i` 个后缀新增长度 `height[i]+1..n-sa[i]`，按数量扣减；落入该段时答案长 `height[i]+k`，`k` 为剩余的 1 下标排名。
- 已知子串 `s[pos..pos+len)`：从 `rk[pos]` 向两侧二分，维持中间 RMQ 不小于 `len`；所得后缀区间就是全部出现位置。
- 不重叠重复子串：二分长度 `L`，将相邻 `height>=L` 的后缀成组，组内最大、最小起点之差至少 `L` 即可行。

比较等长子串先查 LCP，再比较第一个不同字符。外部模式在 `sa` 上二分前缀匹配区间，后缀先耗尽视为更小。多串拼接用各不相同且未出现的分隔符，并记录后缀所属串；字符不够时改整数序列。

题目：P3809、P2408、P2852；#link("https://judge.yosupo.jp/problem/suffixarray")[Suffix Array]。

#code("字符串/后缀排序与最长公共前缀（SA／LCP）/后缀数组.cpp")


]
