#import "只有删除的连通性：倒序变加入/index.typ" as section-0
#import "对象生存期转时间线段树/index.typ" as section-1

#let render(code) = [
#heading(level: 2, outlined: true)[动态连通性（时间线段树与可撤销并查集）] <book-dynamic-connectivity>

离线动态连通性：将边的生效区间挂到时间线段树，DFS 进入节点时加边、退出时回滚；叶子状态恰为该时刻的图。

`DynamicConnectivity(n)` 点号 `1..n`，按时间调用 `add/erase/query`，最后一次 `solve()`，结果仅含询问答案、顺序不变。每次操作都占一个时间位置。

*生效边界*　加入时刻 `l`、删除时刻 `r`，有效区间 `[l,r-1]`；未删除延续到末尾。同一无向边可重复加，`erase` 配最近一次未删副本，删不存在的边触发断言。端点顺序会归一；按边号删除或重边带不同属性时改配对键。

*回滚*　入口记 `snapshot()`，退出 `rollback(snap)`。并查集只按大小合并、不压缩路径；普通失败合并不写历史。有 $A$ 个有效区间、$q$ 次操作时，时间 $O((A log q+q)log n+q log q)$，空间 $O(n+q+A log q)$。

*改统计*　块大小、块数、块权及全局贡献都随修改记录旧值。若每块贡献 `f(size)`，合并前扣两块，合并后加新块。

*动态二分图*　每边要求 `color[u] xor color[v]=1`。异根合并维护势能，同根仍须检查等式；冲突加矛盾数，也必须写历史并回滚。叶子矛盾数为 0 才是二分图。

仅加边用普通并查集，仅删边可倒序。题目直接给生效区间时跳过配对。P5787 需奇偶势能；CF1140F 需维护左右点数与分量贡献。

#code("图论/动态连通性（时间线段树与可撤销并查集）/线段树分治.cpp")


#section-0.render(code)

#section-1.render(code)

]
