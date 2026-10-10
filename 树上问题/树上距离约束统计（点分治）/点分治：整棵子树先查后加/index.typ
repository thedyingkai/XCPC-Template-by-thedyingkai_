#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("点分治：整棵子树先查后加")] <trick-tree-18>
*问题概述*　#text("给定非负整数边权树及整数 ")$K≥0$#text("，统计不同节点无序对 {u,v}，满足唯一简单路径长度 ")$op("dist")(u,v)=K$#text("。点对只计一次，不计 ")$u=v$#text("；零权边允许，要求在点分治中避免把同一邻居子树内的点对算到当前重心。")

*必要思路*　#text("维护已处理子树到重心的距离信息；对当前子树所有点先查询贡献，再整批插入，避免同子树点对重复计入。递归处理删去重心后的各块。距离超阈值剪枝要求非负权；DFS 本身仍可能在长链上爆栈。")

*实现提示*　#text("例：整数非负边权，统计距离恰为 ")$K$#text(" 的无序点对。cnt 可用哈希表，或范围可控时用数组加 touched 清理；同一儿子整批先查后加。哈希实现每层期望线性。")

*伪代码*（需结合题目接口实现）

#trick-code("process_centroid(c):\n  cnt.clear(); cnt[0] = 1\n  for undeleted neighbor v of c:\n    D = collect distances from c in subtree v\n    // collect skips parent and deleted vertices\n    // distances > K may be pruned for nonnegative edges\n    for d in D:\n      answer += cnt.get(K-d, default=0)\n    for d in D:\n      cnt[d] += 1\n  // delete c, recursively decompose remaining components\n// answer uses 64-bit integer; collect DFS may need an explicit stack")

*参考*　#link("https://oi-wiki.org/graph/tree-divide/")[#text("OI Wiki：树分治")]。



]
