#import "区间不同数离线维护最后出现/index.typ" as section-0

#let render(code) = [
#heading(level: 3, outlined: true)[不同数查询：离线扫描] <book-distinct-scan>

静态区间不同数：询问按右端点递增，只在每个值的最后出现位置保留 1，区间和即不同数个数。时间 $O((n+q)log n)$，空间 $O(n+q)$。

`count(a,queries)` 的数组 `a` 用 `0..n-1`，询问却用 *1 下标闭区间*；答案按原询问顺序返回。

扫到新位置时撤销该值的旧标记，再给新位置加 1，随后回答这个右端点的询问。带修改时，静态最后位置不再足够，需换带修改莫队等结构。

*改成其他扫描题*　相同坐标的事件顺序决定边界：统计 `<=x` 时先加入再询问，统计 `<x` 时先询问再加入。矩形拆成带正负号的前缀事件；需反向贡献时另扫一遍。

题目：洛谷 P1972、SPOJ DQUERY；#link("https://judge.yosupo.jp/problem/static_range_count_distinct")[Static Range Count Distinct]。

#code("数据结构与区间查询/离线区间统计/不同数查询：离线扫描/区间不同数.cpp")


#section-0.render(code)

]
