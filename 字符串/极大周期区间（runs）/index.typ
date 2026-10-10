#let render(code) = [
#heading(level: 2, outlined: true)[极大周期区间（runs）] <book-runs>

枚举所有极大周期串。结果 `(l,r,p)` 使用 0 下标半开区间，`p` 为最小周期，`r-l>=2p`，向左或右再扩一位都会破坏该周期。当前实现时间 $O(n log n)$、空间 $O(n)$，依赖后缀数组模板。

周期不要求整除长度：`ababa` 返回 `(0,5,2)`，指数是 `5/2`；求实数指数先转浮点。`ababab` 只返回极大段 `(0,6,2)`。run 数量与全部重复子串数量不同，后者需在每个 run 中进一步统计。

*扩展公式*　候选块起点 `i,j`，`p=j-i`；向左 LCE 为 `a`、向右 LCE 为 `b`，扩为 `[i-a,j+b)`，`a+b>=p` 时至少含两个周期。反串中左扩查询 `lcp(n-i,n-j)`，`i=0` 时直接取 0。

*候选覆盖*　对通常、反向两种字符大小顺序分别建后缀排名，用单调栈找右侧第一个更小排名，产生最长 Lyndon 根。字符大小反序用于补候选，字符串位置反转用于向左 LCE。两种序都要跑，末尾按完整三元组排序去重。

当前三份倍增 SA 加线段树 LCE，每次 LCE 为 $O(log n)$。整数字符须改 SA 输入并离散化，用排名取反代替字节取反。

依据：#link("https://arxiv.org/abs/1406.0263")[The Runs Theorem]。题目：#link("https://judge.yosupo.jp/problem/runenumerate")[Run Enumerate]。

#code("字符串/极大周期区间（runs）/runs.cpp")


]
