#let render(code) = [
#heading(level: 2, outlined: true)[前缀匹配长度（Z 函数）] <book-z-function>

`z[i]=LCP(s,s[i..])`，当前约定 `z[0]=n`，0 下标，空串返回空数组。时间、空间 $O(n)$。

- 模式匹配：计算 `p+分隔符+t`，文本对应位置的 Z 值达到 `|p|` 即匹配；分隔符须不在字符集中，否则改整数序列加独立符号。
- 真 border：枚举 `1<=i<n`，`i+z[i]==n` 时长度 `z[i]` 合法。
- 周期 `p<n`：检查 `z[p]>=n-p`；整块重复另查 `n%p==0`，`p=n` 恒为周期。
- 前缀出现次数：每个 `z[i]` 向长度 `[1,z[i]]` 贡献一次，用差分统计，包含 `i=0` 的整串贡献。

题目：P5410；#link("https://judge.yosupo.jp/problem/zalgorithm")[Z Algorithm]。

#code("字符串/前缀匹配长度（Z 函数）/Z 函数.cpp", mode: "full")


]
