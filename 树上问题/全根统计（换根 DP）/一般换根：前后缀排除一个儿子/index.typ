#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("一般换根：前后缀排除一个儿子")] <trick-tree-08>
*问题概述*　#text("给定树和结合运算 op，带单位元 ")$e$#text("。对每条有向邻接关系 u→v，定义消息 M(u→v) 为 ")$u$#text(" 侧连通块对 ")$v$#text(" 的贡献：从其余邻居送入 ")$u$#text(" 的消息按规定次序合并，再经已知节点转移函数处理。求全部方向消息及每个点作为根的结果，op 不要求可逆或可交换。")

*必要思路*　#text("把每个方向来的贡献按结合律合并，儿子列表做前缀和后缀聚合。发给第 ")$i$#text(" 个儿子的消息由前 ")$i-1$#text(" 项、后 ")$i+1$#text(" 项、父侧贡献组成。运算不交换时还要固定次序；除法在模数下也未必可用。")

*参考*　#link("https://oi-wiki.org/dp/tree/")[#text("OI Wiki：树形 DP")]。



]
