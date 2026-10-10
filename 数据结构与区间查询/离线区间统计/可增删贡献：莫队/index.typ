#let render(code) = [
#heading(level: 3, outlined: true)[可增删贡献：莫队] <book-mo>

离线处理静态区间，要求加入、删除一个位置时能快速更新答案。`Mo(n)` 默认块长 $sqrt(n)$；设加删一次耗时 $T$，总时间 $O(q log q+(q B+n^2/B)T)$，可按 $B≈n/sqrt(q)$ 调整。

`addQuery(l,r)` 使用 1 下标闭区间，返回答案编号；`work(add,del,answer)` 中，加删回调接收位置，`answer(id)` 按原编号存结果。调用前清空统计状态，初始窗口为 `[1,0]`。

*移动顺序*　左扩 `add(--l)`，右扩 `add(++r)`，左缩 `del(l++)`，右缩 `del(r--)`。四组移动结束后再取答案；半开区间须同时改初值与全部移动式。

*频次贡献*　数值大时先离散化。维护平方和，加入前 `ans+=2*cnt[x]+1`，删除前 `ans-=2*cnt[x]-1`。维护相等数对，加入时贡献旧 `cnt[x]`；删除时先减频次，再减新 `cnt[x]`。

*变体*　带修改莫队加时间维及修改的应用、撤销，常取块长 $n^(2/3)$；树上莫队用进出各一次的欧拉序切换点，缺失的 LCA 临时补入；回滚莫队让同块右端只增，左侧临时加入后恢复快照。这些操作需另写回调与排序。

题目：P2709、P1494；#link("https://judge.yosupo.jp/problem/static_range_count_distinct")[Static Range Count Distinct]。

#code("数据结构与区间查询/离线区间统计/可增删贡献：莫队/莫队.cpp")


]
