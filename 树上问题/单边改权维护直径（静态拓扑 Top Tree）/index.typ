#let render(code) = [
#heading(level: 2, outlined: true)[单边改权维护直径（静态拓扑 Top Tree）] <book-top-tree>

固定树形、单边改权、查询全树直径。输入为 $n>=1$ 的连通树，*边权非负*，点号 `0..n-1`。建树 $O(n log n)$，空间 $O(n)$，改单边 $O(log n)$，查直径 $O(1)$。

`setEdge(id,w)` 赋值，`id` 是构造时 `treeEdges` 的 0 下标；`diameter()` 返回长度。`root` 仅影响分解。当前结构没有 `link/cut`、路径修改或子树修改。

*状态*　簇是带至多两个外接边界的连通边集。记 `length/fromLeft/fromRight/diameter` 为边界距离、从两端出发的最远距离、内部直径，下面简记 `len,fl,fr,d`。

#block(breakable: false)[
`compress(L,R)` 连接边界 `(a,b)` 与 `(b,c)`，输出 `(a,c)`：

- `len=L.len+R.len`；
- `fl=max(L.fl,L.len+R.fl)`，`fr=max(R.fr,R.len+L.fr)`；
- `d=max(L.d,R.d,L.fr+R.fl)`。
]

#block(breakable: false)[
`rake(M,S)` 连接 `(a,b)` 与 `(a,c)`，只保留主簇边界 `(a,b)`：

- `len=M.len`；
- `fl=max(M.fl,S.fl)`，`fr=max(M.fr,M.len+S.fl)`；
- `d=max(M.d,S.d,M.fl+S.fl)`。
]

两簇只能在公共边界相交；`rake` 不能交换主、旁簇。单边权为 `w` 时四项均为 `w`，根虚边为 0；距离加法须装入 `i64`。

*改 DP 时检查*　一起替换 `Cluster`、`makeEdge`、`rake`、`compress`。有方向的状态保留端点顺序；公共顶点权规定归属，避免重复计数；根虚边须是合法单位元。允许负边或禁止空路径时须重定初值。输出直径端点需让最远距离附带顶点，并在合并时同步选择。

保留当前平衡合并次序：逐个顺接重链会使高度退化到 $O(n)$。结构有 `2*n-1` 个合并树节点，改单边定位到其子端点叶子后向根重算。

题目：ABC351 G 需重写簇 DP；#link("https://judge.yosupo.jp/problem/tree_diameter")[Tree Diameter] 还需输出路径，可额外两次遍历恢复。

#code("树上问题/单边改权维护直径（静态拓扑 Top Tree）/静态拓扑 Top Tree.cpp")


]
