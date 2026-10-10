#import "恢复方案：保留真正的前驱/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[序列最优值与前驱重建（LIS）] <book-lis>

`longestIncreasingSubsequence(a,strict=true)` 返回一条最长子序列的 *原数组 0 下标*；长度为返回数组大小，按这些下标读取元素即可。空输入返回空数组。时间 $O(n log n)$，空间 $O(n)$。

- 严格递增：默认 `true`，用 `lower_bound` 替换第一个 `>=x` 的末尾。
- 不下降：传 `false`，用 `upper_bound` 替换第一个 `>x` 的末尾。

`tail[len-1]` 是长度 `len` 的最小末尾值，不同位置可能来自不同历史方案。代码记录 `previous`，从最长序列末尾回溯重建；直接输出 `tail` 不能保证得到原数组子序列。

当前返回任意最优方案。要统计数量，可在离散值域上维护“最大长度、对应数量”：合并时取更长，等长相加；严格版本查询 `<x`，不下降版本查询 `<=x`。字典序最小方案需另定重建规则。

来源：wzj52501，#link("https://github.com/wzj52501/awesome-competitive-olympiad-algorithms/blob/c3685028be8ac258074260f8d8bd825faddc4a76/Lectures/STL-and-Applications.pdf")[《STL 及其应用》LIS 专题]。说明文字 CC BY-NC-SA 4.0。

#code("动态规划/序列最优值与前驱重建（LIS）/最长上升子序列.cpp", mode: "full")


#section-0.render(code)

]
