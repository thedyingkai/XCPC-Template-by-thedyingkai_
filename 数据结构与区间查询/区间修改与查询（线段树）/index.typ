#import "维护区间和，支持区间加、区间查询/index.typ" as section-0
#import "维护区间最大值，支持区间加、区间查询/index.typ" as section-1
#import "维护区间和，支持区间加、区间乘、区间查询/index.typ" as section-2
#import "动态开点，维护区间和，支持区间加、区间查询/index.typ" as section-3
#import "维护区间 GCD，支持区间加、区间查询/index.typ" as section-4

#let render(code) = [
#heading(level: 2, outlined: true)[区间修改与查询（线段树）] <book-segment>

本节含五份模板，均用 1 下标闭区间；常规修改、查询 $O(log n)$。按更新类型选板，接口以对应代码为准。

*区间加、区间和或最大值*　和的作用式是 `sum+=d*len`，最大值是 `Max+=d`。两份固定数组板在 `pushDown(root)` 时才把挂起标记作用到本节点并传给儿子；更新须传根编号。若改成立即更新，整段修改、下传、合并的时序须一起改。

*区间乘加、区间和*　标记 `(m,a)` 表示 `x->x*m+a`，再收到 `(M,A)` 后：
$ (m,a) -> (m M,a M+A), quad "sum" -> "sum" M+A dot "len". $
全程取模，单位标记为 `(1,0)`。`op==1` 乘、`op==2` 加；一次仿射 `b*x+c` 先乘后加。赋值标记另存 `hasSet`，赋值覆盖旧乘加。

*动态开点*　初值全 0，从根指针调用 `update(l,r,d)`、`query(l,r)`。`makeTag` 立即更新当前和，`pushdown` 建儿子并传标记。查询也会分配节点，空间按累计节点数算；负增量须把 `u64` 改为 `i64`。坐标可预知时可先离散化。

*区间加、区间 GCD*　令 `d[i]=a[i]-a[i-1]`：
$ gcd(a_l,...,a_r)=gcd(a_l,d_(l+1),...,d_r). $
更新 `[l,r]` 只改 `d[l]` 与 `d[r+1]`。树状数组求当前 `a[l]`，线段树求后面差分的 GCD；`l=r` 直接取 `abs(a[l])`。差分、绝对值与加法均须检查数值范围。

最大值板同样从 0 建树，任意初值需补建树。改维护量时同步写节点合并、标记作用、标记复合；单独改查询不足以维护新信息。

题目：P3372、P3373、AcWing 246；#link("https://judge.yosupo.jp/problem/range_affine_range_sum")[Range Affine Range Sum]。


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

#section-4.render(code)

]
