#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("全根距离和：换根只改变两侧")] <trick-tree-07>
*问题概述*　#text("给定 ")$n$#text(" 点无向树和整数边权，对每个节点 ")$u$#text(" 求 ")$D_u= sum _v op("dist")(u,v)$#text("，dist 为唯一简单路径上的边权和，包含 ")$op("dist")(u,u)=0$#text("。节点均按权重 1 计入，要求一次预处理得到全部 ")$n$#text(" 个答案。")

*必要思路*　#text("先求一个根的答案及子树大小。跨边 u-v（")$v$#text(" 是儿子）换根时，")$v$#text(" 侧 ")$s$#text(" 个点距离减 ")$w$#text("，另一侧 n-s 个加 ")$w$#text("，所以 ")$op("ans")_(v)=op("ans")_(u)+w(n-2s)$#text("。有点权时用两侧权重和替代数量。")

*参考*　#link("https://usaco.guide/gold/all-roots")[#text("USACO Guide：全根树形 DP")]。



]
