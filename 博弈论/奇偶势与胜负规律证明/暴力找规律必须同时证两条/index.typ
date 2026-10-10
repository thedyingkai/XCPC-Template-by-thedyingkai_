#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("暴力找规律必须同时证两条")] <trick-game-20>
*问题概述*　#text("给定有限且每步严格下降的公平游戏，以及猜测的先手必败局面集合 ")$P$#text("。要求证明这个刻画对全部局面成立：")$P$#text(" 内无一步到 ")$P$#text(" 的转移，且每个不在 ")$P$#text(" 的非终止局面都有一步到 ")$P$#text("；必须把终止局面纳入对应规则。")

*必要思路*　#text("验证候选 ")$P$#text(" 集内部不存在一步转移，同时所有非 ")$P$#text(" 状态都能一步进入 ")$P$#text("，才完成败态刻画。打表优先找最小反例；保留边界状态与规则原文。只验证第一条会把过小的 ")$P$#text(" 集误判成正确规律。")

*参考*　#link("https://www.luogu.com.cn/article/hs0vf931")[#text("洛谷 MPLN：公平组合游戏")]。


#pagebreak()


]
