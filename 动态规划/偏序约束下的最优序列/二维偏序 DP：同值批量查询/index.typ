#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("二维偏序 DP：同值批量查询")] <trick-dp-13>
*问题概述*　#text("给定 ")$n$#text(" 个点 ")$(x_i,y_i)$#text("，每点权重 ")$w_i$#text("。选择一条点序列，使两坐标沿序列都严格递增，收益为所选点权重之和。允许选择空序列，求最大收益；同 ")$x$#text(" 或同 ")$y$#text(" 的两个点不能互相转移。")

*必要思路*　#text("按 ")$x$#text(" 排序，用树状数组维护 ")$y$#text(" 前缀最优值。相同 ")$x$#text(" 的点先全部查询，再统一加入；")$y$#text(" 查询到 ")$op("rank")(y)-1$#text("。否则会在同一 ")$x$#text(" 组内部错误转移。若允许等号，需按实际偏序重新确定顺序。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/longest_increasing_subsequence.html")[#text("CP-Algorithms：最长上升子序列")]；#link("https://cp-algorithms.com/data_structures/fenwick.html")[#text("CP-Algorithms：树状数组")]。


参见 #link(<book-cdq>)[多维偏序的 CDQ 实现]。


]
