#import "树计数用度数出现次数/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[树的编码与计数（Prüfer 序列）] <book-prufer>

标号树与长度 `n-2` 的 Prüfer 序列一一对应，点号 `1..n`、`n>=2`。编码输入必须成树，解码编号须在范围内。

- `pruferEncode(n,edges)`、`pruferDecode(code)`：边集与最小堆实现，时间 $O(n log n)$。
- `pruferEncodeLinear(parent)`、`pruferDecodeLinear(code)`：父数组实现，时间 $O(n)$。父数组以 `n` 为根，`parent[n]=0`。

空间均为 $O(n)$。序列每次输出当前最小叶子的邻点；顶点度数等于其出现次数加一。

*计数*　Cayley 公式为 $n^(n-2)$。给定正度数且 $sum_i d_i=2n-2$ 时，树数为
$ (n-2)! / product_i (d_i-1)!. $
仅求度数或方案数时直接用出现次数，无需构造边。

题目：P6086 大范围使用线性版。

#code("树上问题/树的编码与计数（Prüfer 序列）/Prüfer 序列.cpp", parts: ("heap", "linear"))


#section-0.render(code)

]
