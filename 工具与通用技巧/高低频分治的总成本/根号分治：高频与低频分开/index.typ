#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("根号分治：高频与低频分开")] <trick-misc-25>
*问题概述*　#text("给定值序列 ")$a_1…a_n$#text(" 与非负权重 ")$w_i≤W$#text("，静态询问 (x,k)：对值为 ")$x$#text(" 的所有位置，按 ")$w_i≥k$#text(" 筛选后求权重总和。每个值的出现频率可能极不均衡，")$W$#text(" 或不同阈值数允许为高频值预处理表；要求按频率决定枚举位置还是查表。")

*必要思路*　#text("选频率阈值 ")$B$#text("。出现次数")$≤B$#text(" 的值，每问枚举位置并筛选；高频值至多 ")$n/B$#text(" 种，按权重 0…W 建频次加权后缀表，查询直接取表。总时间可估为 ")$O(n+n W/B+q B)$#text("，空间 ")$O(n+n W/B)$#text("。按 ")$n$#text("、")$q$#text("、")$W$#text(" 调 ")$B$#text("，不能不看预处理维度就固定 ")$sqrt(n)$#text("。")

*依据*　自行推导/归纳，理由已写在思路中。


参见 #link(<book-graph-neighbor>)[图上高低度邻居更新]。


]
