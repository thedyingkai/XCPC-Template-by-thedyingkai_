#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("只记录支配其他方案的状态")] <trick-dp-02>
*问题概述*　#text("给定长度为 ")$n$#text(" 的可比较数值序列 ")$a$#text("，求满足 ")$i_1<…<i_k$#text(" 且 ")$a_(i_1)<…<a_(i_k)$#text(" 的最大 ")$k$#text("。相等元素不能延长子序列，本条只求长度，不要求直接从最小末尾数组恢复方案。")

*必要思路*　#text("同样长度下，末尾更小的方案能接上至少同样多的后续元素，故只保留最小末尾；用 lower_bound 更新 tails，")$O(n log n)$#text("。非降序换 upper_bound；tails 数组本身通常不是原序列中的一条答案。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/longest_increasing_subsequence.html")[#text("CP-Algorithms：最长上升子序列")]。



]
