#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("树计数用度数出现次数")] <trick-tree-26>
*问题概述*　#text("给定 ")$n≥2$#text(" 个有编号节点和正整数度数 ")$d_1…d_n$#text("，求满足每点度数恰为 ")$d_i$#text(" 的简单无向树数量；若 ")$sum  d_i≠2(n-1)$#text(" 则无解。无度数限制时求全部有标号树数；")$n=1$#text(" 必须作为单节点、度数 0 的特例处理。")

*必要思路*　#text("Prüfer 序列长度 ")$n-2$#text("，点 ")$i$#text(" 出现 ")$d_i-1$#text(" 次。普通树总数 ")$n^(n-2)$#text("；给定正整数度数且总和 ")$2(n-1)$#text("，树数 ")$(n-2)!/ product (d_i-1)!$#text("。")$n=1$#text("、2 独立处理，模数除法需合法逆元。")

*参考*　#link("https://cp-algorithms.com/graph/pruefer_code.html")[#text("CP-Algorithms：Prüfer 编码")]。


#pagebreak()


]
