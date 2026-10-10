#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("不相交查询取有限全集补集")] <trick-bit-12>
*问题概述*　#text("给定 ")$n$#text(" 位掩码对象及其权值，对查询掩码 ")$S$#text("，求所有与 ")$S$#text(" 按位 AND 为 0 的对象的最大权值，或对象总数。对象可有重复掩码，计数按对象编号，最大值不存在时报告无解；")$n$#text(" 足够小可开 ")$2^n$#text(" 数组。")

*必要思路*　#text("")$T op("and") S=0$#text(" 等价于 ")$T⊆(U op("xor") S)$#text("，其中 ")$U=(1 op("<<") n)-1$#text(" 是本题的 ")$n$#text(" 位全集，构造时需检查移位边界。先按精确掩码聚合，再做 SOS 子集最大值或求和，查询补集位置。状态数组大小为 ")$2^n$#text("，与机器字长 ")$W$#text(" 无关；不存在的最大值用 -INF，不能用 0 混淆负权。")

*参考*　#link("https://usaco.guide/plat/dp-sos")[#text("USACO Guide：SOS DP")]。



]
