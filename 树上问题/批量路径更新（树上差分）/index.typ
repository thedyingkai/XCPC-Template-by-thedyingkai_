#import "点差分：批量统计经过各点的路径/index.typ" as section-0
#import "边差分：LCA 要减两次/index.typ" as section-1

#let render(code) = [
#heading(level: 2, outlined: true)[批量路径更新（树上差分）] <book-tree-difference>

*路径差分*　令 `l=lca(u,v)`：

- 点加 `x`：`d[u]+=x,d[v]+=x,d[l]-=x,d[parent[l]]-=x`。后序累加到父亲后，`d[u]` 为点增量；0 号父亲不计答案。
- 边加 `x`：`d[u]+=x,d[v]+=x,d[l]-=2*x`。后序后 `d[u]` 为父边增量。


#section-0.render(code)

#section-1.render(code)

]
