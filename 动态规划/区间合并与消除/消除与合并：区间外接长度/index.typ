#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("消除与合并：区间外接长度")] <trick-dp-16>
*问题概述*　#text("给定颜色序列 ")$a_1…a_n$#text("。一次操作选择当前序列中一段连续且同色的 ")$k$#text(" 个元素，删除它们并获得 ")$k^2$#text(" 分；删除后左右剩余部分重新相邻。必须删除全部元素，求最大总得分，不能把原来不相邻的同色块直接合并。")

*必要思路*　#text("设 ")$op("dp")_(l,r,k)$#text("：区间 ")$l dots.h r$#text(" 右侧额外连着 ")$k$#text(" 个与 ")$a_(r)$#text(" 同色块。可直接删右端，或先清空中间再把右端并到同色位置。非线性收益使外接长度影响未来，不能提前把每块收益独立结算。")

*参考*　#link("https://www.luogu.com.cn/article/bvovtmzp")[#text("洛谷 LgxTpre：费用提前计算")]。



]
