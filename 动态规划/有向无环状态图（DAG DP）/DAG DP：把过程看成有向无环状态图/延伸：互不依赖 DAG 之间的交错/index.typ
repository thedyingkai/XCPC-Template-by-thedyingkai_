#let render(code) = [
#heading(level: 5, outlined: true, numbering: none)[#text("延伸：互不依赖 DAG 之间的交错")]

*延伸问题*　#text("DAG 被分为 ")$k$#text(" 个节点互不相交的分块，分块间没有任何边。第 ")$i$#text(" 块有 ")$n_i$#text(" 个节点、")$c_i$#text(" 种拓扑序，求整个图的拓扑序数；块内不要求是树。")

*必要思路*　#text("先确定每块内部序列，再选择各块占据的全局位置。答案 ")$((sum_i n_i)!)/(product_i n_i!) product_i c_i$#text("，因为交错不改变块内相对顺序。只要存在跨块边，任意交错就不再合法；可按底层无向连通分量分块，而非仅按 SCC 分块。")

*依据*　由定义推导，证明或边界已给出。


参见 #link(<book-tree-connected-dp>)[树上连通块 DP]。

参见 #link(<book-reroot>)[全根统计与换根 DP]。

参见 #link(<book-probability-dp>)[概率分布 DP]。

参见 #link(<book-self-loop-expectation>)[自环期望方程]。

#pagebreak()


]
