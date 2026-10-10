#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("省掉可由守恒关系恢复的维度")] <trick-dp-03>
*问题概述*　#text("进行 ")$n$#text(" 步选择，每一步恰选 ")$A$#text("、")$B$#text(" 两类中的一类，第 ")$i$#text(" 步选择两类的收益分别为 ")$A_i$#text("、")$B_i$#text("。要求最终恰有 ")$K$#text(" 步选 ")$A$#text("，求最大收益；处理完 ")$i$#text(" 步时两类已选次数之和必为 ")$i$#text("。")

*必要思路*　#text("只记一种数量 ")$j$#text("，另一种必为 i-j。类似地，总量固定时可省掉一类资源、一个坐标或一个人数。先验证剩余信息足以决定所有后续合法性和代价，不能仅因“相关”就删维。此为状态压缩应用的自行归纳。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。



]
