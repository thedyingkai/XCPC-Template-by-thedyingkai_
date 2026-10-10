#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("点集合的直径可由四个端点合并")] <trick-tree-10>
*问题概述*　#text("给定同一棵非负边权树上的两个非空点集 ")$S$#text("、")$T$#text("，已知各集的一组直径端点 (a,b)、(c,d)。求并集 S∪T 的最大点对距离及一组取得该值的端点，不允许重新遍历集合全部元素；单点集合的两个端点可相同。")

*必要思路*　#text("非负权树中，若 ")$S$#text("、")$T$#text(" 各自的直径端点为 (a,b)、(c,d)，并集直径只需比较这四点间距离。由“任意点对集合最远点可由集合直径端点代表”得出，适合在线段树中维护点集直径。空集合与单点集合单独表示。")

*参考*　#link("https://www.luogu.com/article/rjesrsyi")[#text("洛谷：树的相关内容")]。



]
