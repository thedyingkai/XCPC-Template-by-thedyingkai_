Manacher 在字符间插入分隔中心，把奇回文和偶回文统一处理，并复用当前最右回文区间内的镜像半径。`p[i]` 恰好等于该中心在原串中的最长回文长度，因此可以线性求最长回文、回文子串总数，并用 `is_pal(l,r)` 常数时间判断固定半开子串。

下标从 `0` 开始；空区间的 `is_pal` 返回 `false`。`p[i]` 等于该中心对应回文在原串中的长度，最长回文长度即 `max(p)`；`longest()` 在长度相同时取起点最小者。

- 回文子串总数为 $sum_i floor((p_i + 1) / 2)$，答案通常使用 `i64`。
- 枚举中心后，原串回文左端点为 `(i - p[i]) / 2`，长度为 `p[i]`。

- 洛谷 P3805「Manacher」。
- Library Checker 依次要求原串每个字符中心和相邻字符间中心的最长回文长度；当前变换串首尾各多一个 `#`，因此直接输出 `p[1],p[2],...,p[2n-1]`。
- #link("https://judge.yosupo.jp/problem/enumerate_palindromes")[Library Checker · Enumerate Palindromes]
