#import "状态维度交换：按价值记最小重量/index.typ" as section-0
#import "多重背包按余数类拆成队列/index.typ" as section-1
#import "背包循环顺序本身就是约束/index.typ" as section-2
#import "计数时区分组合与排列/index.typ" as section-3

#let render(code) = [
#heading(level: 2, outlined: true)[背包选择] <book-knapsack>

求容量 `V` 下的最大价值，物品体积 `v>0`，数量 `c>=0`，价值可负。`Knapsack(V,exact=false)` 的答案为 `dp[V]`，空间 $O(V)$。

*先选容量含义*　`exact=false` 表示体积至多 `j`，初值全 0；`exact=true` 表示恰好 `j`，仅 `dp[0]=0`，其余为 `Knapsack::NEG`。恰好装满时须检查 `dp[V]!=NEG`。

#table(
 columns: (auto, 1fr, auto),
 table.header([接口], [件数与循环], [每种物品]),
 [`add01(v,w)`], [一件，容量倒序], [$O(V)$],
 [`addComplete(v,w)`], [无限件，容量正序], [$O(V)$],
 [`addBoundedBinary(v,w,c)`], [至多 `c` 件，二进制拆成 01 物品], [$O(V log(c+1))$],
 [`addBoundedQueue(v,w,c)`], [至多 `c` 件，按容量模 `v` 分组], [$O(V)$],
)

*单调队列转移*　上一层记为 $g$，容量写成 $r+t v$：
$ f(r+t v)=t w+max_(max(0,t-c)<=s<=t)(g(r+s v)-s w). $
维护窗口内 `g-s*w` 的最大值，只加入可达状态。读取独立的 `old` 数组，避免把本轮更新再当旧层。二进制版本先截 `c=min(c,V/v)`。

同类物品只选一种接口，不同类型可混用。价值及中间式用 `i128`，绝对值须小于 $2^120$。零体积外部处理：无限件且价值为正时答案无界。方案计数、每组恰选一件需要另写状态与转移。

来源：wzj52501，#link("https://github.com/wzj52501/awesome-competitive-olympiad-algorithms/blob/c3685028be8ac258074260f8d8bd825faddc4a76/Lectures/Dynamic-Programming-Talk.pdf")[《浅谈动态规划》29–33 页]。

#code("动态规划/背包选择/背包.cpp")


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

]
