#import "使用与状态/index.typ" as section-0
#import "路径统计改法/index.typ" as section-1
#import "点分治：整棵子树先查后加/index.typ" as section-2
#import "重心的本质是平衡分割/index.typ" as section-3

#let render(code) = [
#heading(level: 2, outlined: true)[树上距离约束统计（点分治）] <book-centroid>

点分治用于统计树上的路径或点对贡献。每次选择当前连通块的重心，处理经过重心的路径，再删除重心并递归处理各个剩余连通块。删除重心后，每块大小不超过原块的一半，分治层数为 $O(log n)$；若 `calc` 对大小为 $m$ 的连通块耗时 $O(m)$，总时间为 $O(n log n)$，若耗时 $O(m log m)$，总时间为 $O(n log^2 n)$。框架空间为 $O(n)$，另加题目所需的统计空间。


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

]
