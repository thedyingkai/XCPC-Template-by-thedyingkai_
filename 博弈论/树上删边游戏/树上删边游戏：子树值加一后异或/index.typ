#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("树上删边游戏：子树值加一后异或")] <trick-game-17>
*问题概述*　#text("给定以 ")$r$#text(" 为根的无向树。每步删除一条现存边，并同时删除断开后不再与 ")$r$#text(" 连通的全部节点及边；根始终保留。双方轮流行动，无法删边者输，求初始树的 SG 或先手胜负。")

*必要思路*　#text("叶子 ")$op("sg")=0$#text("。设 children(u) 为 ")$u$#text(" 的儿子集合，则 ")$op("sg")(u)=op("xor")_(v in op("children")(u))(op("sg")(v)+1)$#text("。分支独立，子树顶端加一条可剪边，使所有原局面多一个后继终止态，归纳其 SG 增 1。仅适用于剪边后移除根外连通块的规则。")

*参考*　#link("https://www.luogu.com/article/7hk1nffs")[#text("洛谷原创：树的删边游戏与无向图的删边游戏")]。



]
