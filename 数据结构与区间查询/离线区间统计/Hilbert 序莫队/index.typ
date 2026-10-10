#import "恰好 K 种=至多 K 种-至多 K-1 种/index.typ" as section-0

#let render(code) = [
#heading(level: 3, outlined: true)[Hilbert 序莫队] <book-variant-021>

将静态区间 `(l,r)` 按 Hilbert 序排序，随后用普通莫队的加删回调移动窗口。适合端点移动常数较大、希望改善访问局部性的题。

使用 1 下标闭区间，内部坐标减一，`u64` 序号要求坐标小于 $2^31$。`work` 从 `[1,0]` 开始：扩张时先移端点再加入，收缩时先删除再移端点；答案按询问 `id` 保存。

与普通莫队相比只改变排序。排序为 $O(q log q)$，总耗时还取决于移动量与加删成本；可与块长 $B≈n/sqrt(q)$ 的普通莫队比较。强制在线或带时间修改的题须换相应算法。

题目：P1494、P2709；#link("https://judge.yosupo.jp/problem/static_range_count_distinct")[Static Range Count Distinct]。

#code("数据结构与区间查询/离线区间统计/Hilbert 序莫队/Hilbert 序莫队.cpp")


#section-0.render(code)

]
