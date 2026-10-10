#let render(code) = [
#heading(level: 2, outlined: true)[最长回文半径（Manacher）] <book-manacher>

线性预处理所有回文中心，时间、空间 $O(n)$。当前变换串首尾和字符间均有分隔中心，`p[i]` 等于该中心在原串中的最长回文长度。

- 最长长度为 `max(p)`；`longest()` 同长取最左起点。
- `is_pal(l,r)` 查询 0 下标半开区间，空区间返回 `false`。
- 中心 `i` 的最长回文起点为 `(i-p[i])/2`，长度为 `p[i]`。
- 回文子串总数为 $sum_i floor((p_i+1)/2)$，用 `i64` 累加。

题目：P3805；#link("https://judge.yosupo.jp/problem/enumerate_palindromes")[Enumerate Palindromes] 依次输出 `p[1..2n-1]`，去掉首尾两个额外中心。

#code("字符串/最长回文半径（Manacher）/Manacher.cpp", mode: "full")


]
