#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 5, outlined: true, numbering: none)[#text("延伸：若儿子必须按标签递增访问")]

*延伸问题*　#text("仍给定互异标签前序 ")$p$#text("，根为 ")$p_1$#text("，但 DFS 必须按儿子标签从小到大访问。统计符合该序列的简单无向树，不能再任意选择儿子顺序；只保留父子关系作为树方案。")

*必要思路*　#text("不再统一是 Catalan 数。令 ")$F(l,r)$#text(" 为以 ")$p_l$#text(" 为根、前序区间恰为 [l,r] 的树数。其儿子子树把 ")$[l+1,r]$#text(" 划分为连续非空段，各段首元素即儿子标签，必须严格递增。定义 G(pos,last,r) 为剩余区间 [pos,r] 的合法儿子森林数，按下段终点 ")$t$#text(" 枚举并乘 ")$F(op("pos"),t)$#text("。用区间长度及 last 状态记忆化，至多 ")$O(n^3)$#text(" 状态、O(n⁴) 转移；last 可以离散为标签排名，并用 0 哨兵。")

#trick-code("F(l,r):\n  return G(l+1, 0, r)  // labels ranked 1..n\nG(pos,last,r):\n  if pos > r: return 1\n  if rank(p[pos]) <= last: return 0\n  answer = 0\n  for t = pos..r:\n    answer += F(pos,t) * G(t+1,rank(p[pos]),r)\n  return answer\n// memoize F and G; answer = F(1,n)")

*依据*　由定义推导，证明或边界已给出。


]
