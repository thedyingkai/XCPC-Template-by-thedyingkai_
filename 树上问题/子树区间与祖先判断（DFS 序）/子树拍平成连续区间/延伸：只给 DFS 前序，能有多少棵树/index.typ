#let render(code) = [
#heading(level: 5, outlined: true, numbering: none)[#text("延伸：只给 DFS 前序，能有多少棵树")]

*延伸问题*　#text("给定 ")$n≥1$#text(" 个互异标签的排列 ")$p$#text("，指定根为 ")$p_1$#text("。统计这些标签上的简单无向树，使存在一种儿子访问顺序，DFS 首次进入序恰为 ")$p$#text("；同一棵带标签树只计一次。没有边集合、度数或编号排序限制，儿子顺序可以自由选择。")

*必要思路*　#text("每种有序根树形状，按前序位置依次填入 ")$p$#text("，得到一棵候选树；反之给定树及 ")$p$#text("，各儿子子树的先后次序由它们在 ")$p$#text(" 的位置唯一确定，因此两者一一对应。")$n$#text(" 点有序根树由 ")$n-1$#text(" 次下行、")$n-1$#text(" 次上行的合法括号编码计数，答案为 ")$binom(2n-2,n-1)-binom(2n-2,n)$#text("，即 ")$op("Catalan")(n-1)$#text("。注意这不是任意标号树的 Cayley 数。")

*参考*　#link("https://cp-algorithms.com/combinatorics/catalan-numbers.html")[#text("CP-Algorithms：Catalan 数")]。


]
