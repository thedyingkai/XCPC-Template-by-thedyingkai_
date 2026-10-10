#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("指示变量：复杂事件逐个贡献")] <trick-math-29>
*问题概述*　#text("给定有限对象集合 ")$E$#text(" 及概率空间，对每个 ")$e$#text(" 定义事件 ")$A_e$#text(" 和指示变量 ")$I_e$#text("。随机得分 ")$X= sum _e I_e$#text("，已能单独计算每个 ")$P(A_e)$#text("，求 ")$E_(X)$#text("；事件之间允许任意相关性，不要求独立。")

*必要思路*　#text("对每个事件 ")$A_e$#text("，用 ")$I_e$#text(" 表示它发生时为 1、不发生时为 0。则 ")$E[X]=sum_(e in E)P(A_e)$#text("，由期望线性性得到，不需事件独立。独立性只在拆联合概率乘积时需要；求二阶矩 ")$E_(X^2)$#text(" 则需两两事件联合概率，不能直接把 ")$E_(X)$#text(" 平方。")

*参考*　#link("https://www.luogu.com/article/ms32f221")[#text("洛谷：概率和期望")]。



]
