#let render(code) = [
#heading(level: 3, outlined: true)[乱序多重集的组合数排名] <comm-multiset>

q 种符号，恰好 L 个无序元素且重复次数保留，容量是 $binom(L+q-1,q-1)$；至多 L 个且总长度可见，容量是 $binom(L+q,q)$。乱序后不能再按 $q^L$ 计算。

将排序后符号 $a_i in [0,q)$ 映成严格递增 $b_i=a_i+i$，其中 i 从 0 开始。固定长度的 colex 排名为
$ R=sum_(i=0)^(L-1) binom(b_i,i+1). $
逆排名依次选最大的 b，使相应组合数不超过剩余 R。变长编码先按长度段分配连续区间，再在该段组合排名；接收者从实际长度知道段偏移。

对 256 符号、512 比特载荷，恰好 261 个状态数 $binom(516,255)<2^512$，至多 261 个却有 $binom(517,256)>=2^512$。长度本身提供信息。这只是容量和一种构造，不代替原题的全部评分约束。

代码依赖 #raw("#include <boost/multiprecision/cpp_int.hpp>")，用 cpp_int 精确计算，不用浮点组合数或 64 位截断。输出排序只为确定代表，信道洗牌后再排序恢复；允许长度范围、符号域和位序须双方一致。#link("https://qoj.ac/problem/2006")[IOI 2011 Parrots]。

#code("通信题/容量计算与序列化/乱序多重集的组合数排名/多重集排名编码.cpp", mode: "full")
]
