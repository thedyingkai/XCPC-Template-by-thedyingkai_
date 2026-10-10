#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("MEX 上界很小：忽略过大值")] <trick-misc-36>
*问题概述*　#text("维护大小至多 ")$N$#text(" 的非负整数多重集合，支持插入、删除一份存在的值、查询 MEX，即最小未出现非负整数。输入值可达 ")$10^18$#text("，重复值影响频次；空集合 MEX 为 0，")$N$#text(" 是整个操作序列的容量上界。")

*必要思路*　#text("集合大小始终不超过 ")$N$#text("，因此 MEX 必在 ")$0 dots.h N$#text("。固定维护这 ")$N+1$#text(" 个值的出现次数及缺失集合；频次从 0 到 1 时移除缺失值，从 1 到 0 时加回。仅忽略大于 ")$N$#text(" 的输入值，不能按当前集合大小丢弃以后可能影响 MEX 的值。空集合返回 0。")

*参考*　#link("https://cp-algorithms.com/sequences/mex.html")[#text("CP-Algorithms：MEX")]。



]
