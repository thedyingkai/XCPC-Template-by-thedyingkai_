#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("Slope Trick：不枚举巨大整数坐标")] <trick-dp-31>
*问题概述*　#text("给定整数序列 ")$a_1…a_n$#text("，选择整数序列 ")$b_1≤…≤b_n$#text("，允许 ")$b_i$#text(" 在整个整数域取值。修改代价为 ")$sum |a_i-b_i|$#text("，求最小代价；本条只求最优值，不要求输出 ")$b$#text("，不能把单调性改成严格递增后原样套用。")

*必要思路*　#text("dp 转移是取前缀最小值再加绝对值，形成凸分段线性函数。用堆维护斜率变化点，可 ")$O(n log n)$#text(" 求最小值。此例可逐个把 ")$a_(i)$#text(" 插入大根堆；若堆顶大于 ")$a_(i)$#text("，加差值并把堆顶替换为 ")$a_(i)$#text("。恢复 ")$b$#text(" 需额外记录。")

*实现提示*　#text("本例是非降序 L1 回归，不是所有 Slope Trick 的通用板。价值和答案用宽整数；")$O(n log n)$#text(" 时间、")$O(n)$#text(" 空间，只求最优值。")

*伪代码*（需结合题目接口实现）

#trick-code("max_heap H = empty\nanswer = 0\nfor x in a:\n  H.push(x)\n  if H.top() > x:\n    answer += H.top() - x\n    H.pop()\n    H.push(x)\nreturn answer")

*参考*　#link("https://usaco.guide/adv/slope-trick")[#text("USACO Guide：Slope Trick")]。



]
