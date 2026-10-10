#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("bitset 记录新出现的和以恢复方案")] <trick-bit-20>
*问题概述*　#text("在上一条 ")$0/1$#text(" 可达性模型中，再给目标 ")$T≤V$#text("。若 ")$T$#text(" 可达，要求输出一组物品下标，使重量和恰为 ")$T$#text(" 且每件最多一次；只要求任意合法方案，不要求所选件数最少。")

*必要思路*　#text("计算 ")$op("new")=(op("old") op("<<") w) op("&")  op("~") op("old")$#text("，仅对新出现的和记 (物品编号,前驱和)。每个和首次出现一次，记录总量 ")$O(V)$#text("，之后沿前驱恢复；位移前快照须正确。若要最少件数，首次出现不等于最优。此为“每状态只记录一次”的自行推导。")

*参考*　#link("https://www.luogu.com.cn/article/krybn2f5")[#text("洛谷 听取MLE声一片：Trick 总结")]。


参见 #link(<book-bitset>)[动态位集代码]。


]
