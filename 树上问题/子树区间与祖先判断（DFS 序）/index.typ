#import "子树拍平成连续区间/index.typ" as section-0
#import "祖先关系由进入退出时间判定/index.typ" as section-1

#let render(code) = [
#heading(level: 2, outlined: true)[子树区间与祖先判断（DFS 序）] <book-dfs-order>

*DFS 序*　仅记进入时间：子树为 `[dfn[u],dfn[u]+sz[u]-1]`，祖先判定为 `dfn[u]<=dfn[v]<dfn[u]+sz[u]`。点加子树和做单点修改、区间查询；子树加点查做区间差分。


#section-0.render(code)

#section-1.render(code)

]
