#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("贡献提前计算：等待成本")] <trick-dp-05>
*问题概述*　#text("数轴上有 ")$n$#text(" 盏灯，第 ")$i$#text(" 盏位于 ")$x_i$#text("，未关闭时每单位时间产生非负费用 ")$c_i$#text("。人从坐标 ")$s$#text(" 在时刻 0 出发，以单位速度移动，关闭经过的灯不耗时；所有灯最终必须关闭。求从出发到全部关闭的累计费用 ")$sum  c_i t_i$#text("，其中 ")$t_i$#text(" 是第 ")$i$#text(" 盏灯的关闭时刻。")

*必要思路*　#text("按坐标排序。经过的灯顺手关闭不劣，因此已关闭部分形成包含起点的区间；若起点不是灯的位置，插入费用率为 0 的虚拟灯并从该单点初始化。记 ")$op("dp")_(l,r,op("side"))$#text("。每走 Δ距离，直接加“当前所有未关闭灯的费用率之和")$Δ$#text("距离”，无需记录累计时间。要求移动时间与距离成正比、费用率非负。")

*参考*　#link("https://www.luogu.com.cn/article/bvovtmzp")[#text("洛谷 LgxTpre：费用提前计算")]。



]
