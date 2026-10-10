#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("关键点按 DFS 序成环：边被算两次")] <trick-tree-12>
*问题概述*　#text("给定非负边权树，维护关键点集合 ")$K$#text("，支持插入一个尚不在集合的节点或删除一个已有节点。每次操作后求包含全部 ")$K$#text(" 的最小连通子树的边权和；集合为空或只有一个点时答案为 0。")

*必要思路*　#text("关键点按 tin 排成环，相邻距离和 ")$P$#text(" 恰等于子树边权和的两倍。插入 ")$x$#text(" 只改前驱 ")$p$#text("、后继 ")$s$#text("：")$Δ P=op("dist")(p,x)+op("dist")(x,s)-op("dist")(p,s)$#text("。集合仅一两个点时按环关系处理。注意是 ")$P/2$#text("，不能漏掉回首距离或除二。自行推导。")

*参考*　#link("https://www.luogu.com.cn/article/krybn2f5")[#text("洛谷 听取MLE声一片：Trick 总结")]。



]
