#import "延伸：一般 DAG 的拓扑序数量/index.typ" as section-0
#import "延伸：拓扑序什么时候唯一/index.typ" as section-1
#import "延伸：有根森林的祖先先行排列数/index.typ" as section-2
#import "延伸：互不依赖 DAG 之间的交错/index.typ" as section-3

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("DAG DP：把过程看成有向无环状态图")] <trick-dp-35>
*问题概述*　#text("给定有限有向无环图、边权以及起点 ")$s$#text("、终点 ")$t$#text("，求 ")$s$#text(" 到 ")$t$#text(" 的最大路径权重和，不可达时报告无解。边权可为负，合法路径必须沿图中有向边；要求依据拓扑依赖计算状态，而不是仅按节点编号循环。")

*必要思路*　#text("以严格递增或递减的量给状态排序，在拓扑顺序上转移；状态稀疏时用记忆化搜索只访问可达点。记忆化必须区分未计算与值为 0；若操作可回到旧状态，先处理环，不能仍当 DAG。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

]
