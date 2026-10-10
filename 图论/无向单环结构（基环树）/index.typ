#import "基环树：先剥树枝，再处理环/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[无向单环结构（基环树）] <book-unicyclic>

拆分连通无向基环树的唯一环与挂树，预处理 $O(n+m)$。输入须恰有 `n` 点、`n` 边；`build()` 检查边数和连通性，失败返回 `false`。

`addEdge(u,v,w)` 返回 0 下标边号，支持自环与平行边构成的二元环。`cycleEdge[i]` 连接 `cycle[i]` 和下一环点；`root[u]` 为挂树环根，`parent/parentEdge/dep/dist` 保存向环的父亲、父边、深度和距离。

*距离查询*　`clockwiseDistance` 沿记录顺序求环距。不同挂树的距离为两段到环根距离加两环向较小值；同一挂树须另接 LCA。`shorterCycleDistance` 按非负边权最短路使用，距离与前缀和须装入 `i64`。

环由逐层删除度数不超过 1 的点得到。环形 DP、直径可复制环后配单调队列或双指针，并限制窗口长度。

#code("图论/无向单环结构（基环树）/无向基环树.cpp")


#section-0.render(code)

]
