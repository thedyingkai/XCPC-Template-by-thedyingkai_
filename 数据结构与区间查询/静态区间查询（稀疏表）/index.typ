#import "bitset 小块 RMQ：把单调栈存成掩码/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[静态区间查询（稀疏表）] <book-sparse>

静态数组区间查询，预处理与空间 $O(n log n)$，单次 $O(1)$。`query(l,r)` 使用 0 下标非空闭区间。

- 普通 `SparseTable`：运算须有结合律和幂等性，例如最小值、最大值、GCD；两个查询块可重叠。
- 不交稀疏表：只要求结合律，适用区间和、矩阵乘。`Op(a,b)` 保留左右顺序，可处理非交换运算。

两份代码都不定义空区间单位元。若需返回最值位置，元素存 `(value,index)`，比较时规定同值取左或取右。二维 RMQ 两维分别倍增，空间为 $O(n m log n log m)$。

题目：P3865；#link("https://judge.yosupo.jp/problem/staticrmq")[Static RMQ]。

#code("数据结构与区间查询/静态区间查询（稀疏表）/稀疏表.cpp", parts: ("sparse-table", "disjoint-sparse-table"))


#section-0.render(code)

]
