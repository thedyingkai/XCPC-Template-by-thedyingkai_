#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("全点对距离：把点对换成边贡献")] <trick-tree-04>
*问题概述*　#text("给定 ")$n$#text(" 点无向树及整数边权 ")$w_e$#text("，定义 dist(u,v) 为唯一简单路径的边权和。求 ")$sum _(1≤u<v≤n)op("dist")(u,v)$#text("，按两个不同节点组成的无序对计数，不计自身点对；边权允许为负，仍按路径和定义。")

*必要思路*　#text("删去边 ")$e$#text(" 后两侧为 ")$s$#text(" 与 n-s 个点，恰有 s(n-s) 个点对经过此边；答案 ")$sum  w_e s(n-s)$#text("。指定关键点则改成两侧关键点数量乘积；有序点对乘 2。公式本身允许负权边，但“最远”性质另论。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
