#let render(code) = [
#heading(level: 2, outlined: true)[树上路径离线统计（欧拉序莫队）] <book-tree-mo>

树上莫队记录进出各一次，先令 `tin[u]<=tin[v]`。`l==u` 用 `[tin[u],tin[v]]`；否则用 `[tout[u],tin[v]]`，回答前临时切换 LCA，回答后撤销。

参见 #link(<book-mo>)[区间莫队的增删贡献框架]。


]
