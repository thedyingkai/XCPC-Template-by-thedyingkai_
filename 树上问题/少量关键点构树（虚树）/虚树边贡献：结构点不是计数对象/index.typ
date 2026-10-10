#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("虚树边贡献：结构点不是计数对象")] <trick-tree-14>
*问题概述*　#text("同一棵树上的关键点询问有两种独立模型：①给非负距离边权及关键集合 ")$K$#text("，求不同关键点无序对的距离和；②给非负切边费用、固定根 ")$r$#text("∉")$K$#text("，删边使所有 ")$K$#text(" 中节点都与 ")$r$#text(" 不连通，求最小费用。压缩树的距离权与最小切边费用不能混用。")

*必要思路*　#text("距离和用虚树子树关键数 ")$c$#text("：边贡献 w c(k-c)。切边问题要求固定根不是待隔离的关键点。若是非负切边代价，虚边取原链最小值，关键儿子必须切，非关键儿子取 min(切边,儿子 DP)。补入的 LCA 和固定根不自动算关键对象。")

*实现提示*　#text("本段仅对应最小切边隔离。构虚树前补入固定根；虚边 cutCost 用原树倍增/树剖查链上最小切边代价，不能使用距离权重。根不能是关键点。")

*伪代码*（需结合题目接口实现）

#trick-code("postorder(u):\n  dp[u] = 0\n  for virtual child v of u:\n    postorder(v)\n    c = minimum cut cost on original path u -> v\n    if v is a key:\n      dp[u] += c\n    else:\n      dp[u] += min(c, dp[v])\nanswer = dp[fixed_root]")

*参考*　#link("https://oi-wiki.org/graph/virtual-tree/")[#text("OI Wiki：虚树")]。



]
