#let render(code) = [
#heading(level: 2, outlined: true)[单模式匹配（KMP）] <book-kmp>

单模式匹配，预处理模式加扫描文本为 $O(m+n)$，辅助空间 $O(m)$ 加答案。`match` 返回允许重叠的 *1 下标起点*；空模式返回空结果。

`nxt[i]` 用 1 下标，表示长度 `i` 前缀的最长真 border 长度；失配时从已匹配长度 `j` 跳到 `nxt[j]`。

*border 与周期*

- 枚举长度 `x` 前缀的真 border：先 `x=nxt[x]`，再不断跳，直到 0。
- 最小周期 `p=n-nxt[n]`；要求整块重复还须 `n%p==0`。
- 前缀出现次数：`cnt[1..n]=1`，按 `i=n..1` 累加 `cnt[nxt[i]]+=cnt[i]`。
- 长 `L` 的串同时有周期 `p,q`，且 `L>=p+q-gcd(p,q)`，则 `gcd(p,q)` 也是周期。

失配树令 `nxt[i]` 为 `i` 的父亲，祖先对应 border。求两个前缀共同的真 border 时，若 LCA 等于任一输入节点，再跳一次 `nxt`。

等长串循环同构可在 `s+s` 中找 `t`，限制 1 下标起点不超过 `n`；排除原位置则去掉起点 1。两个模式出现间距 `d<m` 可重叠，当且仅当存在长度 `m-d` 的 border。

题目：P3375。

#code("字符串/单模式匹配（KMP）/KMP.cpp", mode: "full", ignore-main: false)


]
