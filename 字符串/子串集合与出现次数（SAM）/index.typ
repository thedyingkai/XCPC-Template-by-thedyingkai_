#let render(code) = [
#heading(level: 2, outlined: true)[子串集合与出现次数（SAM）] <book-sam>

将文本的子串按相同结束位置集合 `endpos` 合并。状态 `v` 表示长度 `(len[link[v]],len[v]]` 的子串；转移是在尾部加字符，`link` 指向较短后缀。依次 `extend(c)` 构造，当前类只提供构造接口。

`n>=2` 时至多 `2n-1` 状态，空串与单字符分别为 1、2 状态。`unordered_map` 按平均常数查找估计，构造期望 $O(n)$、空间 $O(n)$；固定小字符集可改数组。

*出现次数*　普通新状态初值 1，克隆初值 0；按 `len` 降序执行 `occ[link[v]]+=occ[v]`。克隆复制转移、旧 `link`，长度改成 `len[p]+1`，自身不新增文本终点。随附主程序只对 `occ>=2` 求最大 `occ*len`，无重复时输出 0。

*常用查询*

- 不同子串数：对非初始状态求和 `len[v]-len[link[v]]`。
- 模式出现次数：从 0 沿字符转移，成功后读该状态 `occ`。至少出现 `k` 次的最长子串取满足 `occ>=k` 的最大 `len`。
- 另一串的最长公共子串：同时维护状态 `v` 与实际长度 `l`。失配沿 `link` 回退并令 `l=len[v]`；找到转移后前进并 `l++`，根也失配则清零。到达状态后保留实际 `l`，不直接赋为 `len[v]`。
- 字典序第 $k$ 小：后缀计数 `ways[u]=sum(1+ways[v])`，每条边先计立即结束，再计后续；若按出现次数重复计，改成 `sum(occ[v]+ways[v])`。计数可按 `k` 截断，出边必须按字符排序。

*区间内出现*　保存每个文本前缀的终点状态，将 `link` 反向成树。模式状态的子树包含其全部结束位置。模式长 `m`、要求完整落在 `[L,R]` 时，统计结束位置 `[L+m-1,R]`，可用 DFS 序配主席树或离线树状数组。

多串匹配逐串扫描；直接无分隔拼接会增加跨边界子串。

题目：P3804；#link("https://judge.yosupo.jp/problem/number_of_substrings")[Number of Substrings]。

#code("字符串/子串集合与出现次数（SAM）/SAM.cpp", mode: "full", ignore-main: false)


]
