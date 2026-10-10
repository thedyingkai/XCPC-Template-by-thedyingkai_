#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("bitset 小块 RMQ：把单调栈存成掩码")] <trick-bit-23>
*问题概述*　#text("给定静态数值数组，回答大量闭区间 [l,r] 的最大值查询。把数组分成长度不超过机器字位数 ")$W$#text(" 的小块，要求块内查询 ")$O(1)$#text("，跨块用预处理的整块最值结构；相等最大值只求数值，不要求特定下标。")

*必要思路*　#text("在不超过机器字长的小块内，单调栈保存可能成为区间最大值的位置，并为每个右端点保存掩码；移掉 ")$l$#text(" 之前的位，最低置位位置就是候选最大值。完整块用 ST 表。最值同值弹栈规则必须一致，查询掩码非零再 ctz。")

*参考*　#link("https://www.luogu.com.cn/article/f3jhcq3e")[#text("洛谷 critnos：位运算技术")]。



]
