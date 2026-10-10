#import "绝对值和的最优位置是中位数/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[动态中位数（对顶堆）] <book-median-heaps>

维护可重集合的下中位数。`Set::add(x)` 插入，`Set::del(x)` 删除一个同值元素，不存在则不动；修改 $O(log n)$，查询 $O(1)$，空间 $O(n)$。

`Set::init()` 清空；非空时调用 `Set::get_middle()`。`less` 存较小的一半，大小与 `greater` 相等或多一，且 `max(less)<=min(greater)`；答案为 `*less.rbegin()`。

*改排名*　求第 $k$ 小时改平衡规则，使 `less` 恰有 $k$ 个元素。求上中位数时，两堆等大取 `*greater.begin()`，否则仍取 `less` 最大值。求两个中位数的平均数，先扩宽再相加。

滑动窗口每次加入新值、删除旧值后查询。题目：洛谷 P1168；P1801 需随询问调整目标排名。

#code("数据结构与区间查询/动态中位数（对顶堆）/对顶堆.cpp")


#section-0.render(code)

]
