#let render(code) = [
#heading(level: 2, outlined: true)[可合并优先队列（左偏树）] <book-leftist>

维护可合并的小根堆。合并、弹出 $O(log n)$，取堆顶 $O(1)$；空间按累计创建节点数计算。

- `newNode(x)` 返回单元素堆根；空根为 `0`。
- `a=h.merge(a,b); b=0;`：破坏性合并，两个输入堆必须不相交，旧根不再代表独立集合。
- 非空时 `h.top(a)` 取最小值，`a=h.pop(a)` 弹出；*每次修改必须接住新根*。

`rank(0)=0`，叶子为 1；维持 `rank(left)>=rank(right)`、`rank(node)=rank(right)+1`。合并仅沿右链下降，其长度为对数；整棵树高度仍可能线性，不宜直接深递归遍历。

当前按 `(key,id)` 判优，不回收弹出节点，也不提供任意删除或所属堆查询。按原元素编号操作时，另加代表元与删除标记。改大根堆须统一比较规则；子树预算题可合并后持续弹出最大费用，另存总费用与数量。

来源：wzj52501，#link("https://github.com/wzj52501/awesome-competitive-olympiad-algorithms/blob/c3685028be8ac258074260f8d8bd825faddc4a76/Lectures/Advanced-Data-Structures.pdf")[《高级数据结构》43–49 页]。说明文字 CC BY-NC-SA 4.0。

#code("数据结构与区间查询/可合并优先队列（左偏树）/左偏树.cpp")


]
