#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("只有删除的连通性：倒序变加入")] <trick-misc-28>
*问题概述*　#text("给定初始无向图和离线操作序列，操作只有删除指定边或查询两点是否连通。删除不存在的边视为无效，重复删除需按有效性处理；查询针对该时刻删除完成后的图，没有边加入操作。")

*必要思路*　#text("先把所有待删边去掉建立最终状态，再逆序逐条加入，对应询问在正确时刻回答。重复删同一条边要用次数/有效性处理，否则逆序过早恢复。在线混合增删已不是这条简单套路。")

*参考*　#link("https://cp-algorithms.com/data_structures/disjoint_set_union.html")[#text("CP-Algorithms：并查集应用")]。



]
