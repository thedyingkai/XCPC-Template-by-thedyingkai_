#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("连续段 DP：按值插入而非按位置填")] <trick-dp-32>
*问题概述*　#text("给定 ")$n$#text(" 个互异整数 ")$a_i$#text(" 和非负预算 ")$B$#text("，把它们各使用一次排成排列 ")$p$#text("。排列代价为 ")$sum _(i=1)^(n-1)|p_i-p_(i+1)|$#text("，求代价不超过 ")$B$#text(" 的排列数；按有序排列计数，反向排列通常视为不同方案。")

*必要思路*　#text("按值排序后从小到大加入元素，状态记录已加入元素形成的连续块数 ")$j$#text("、已确定全局端点数 ")$e∈(0,1,2)$#text(" 和累计代价。相邻值差 Δ 出现时，尚未闭合的边端数为 ")$2j-e$#text("，先增加 ")$(2j-e)Δ$#text(" 的代价。新点可独立成块、接一块或连接两块；还须标记是否作为最终首尾。转移重数按合法开放端数推导，末态只有一块且两个端点已确定，不能把无序块当有序排列少计。")

*参考*　#link("https://www.luogu.com/article/vv9lgu8h")[#text("洛谷 MatrixGroup：连续段 DP")]。



]
