#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("阈值查询变激活顺序")] <trick-misc-08>
*问题概述*　#text("给定静态数组 ")$a$#text(" 及 ")$q$#text(" 个询问 (l,r,X)，返回区间 [l,r] 中满足 ")$a_i≤X$#text(" 的下标个数。阈值等号计入，重复值按出现位置分别计数；没有在线修改，允许重排询问并还原答案次序。")

*必要思路*　#text("把对象按权值、查询按 ")$X$#text(" 排序，逐步激活所有符合阈值的对象，维护 Fenwick 或 DSU。小于与小于等于决定同权事件先后顺序。需要未来修改历史时，简单一次扫描不再覆盖全部状态。")

*参考*　#link("https://www.luogu.com.cn/article/krybn2f5")[#text("洛谷 听取MLE声一片：Trick 总结")]。



]
