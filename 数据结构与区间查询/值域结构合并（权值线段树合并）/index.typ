#let render(code) = [
#heading(level: 2, outlined: true)[值域结构合并（权值线段树合并）] <book-segment-merge>

多个非负频次集合共用值域 `[1,M]` 和节点池。`MergeableSegmentTree(M)` 的空根为 0；所有根使用同一份离散化。

- `root=add(root,p,delta)`：增减频次，修改后叶子频次须非负，总频次须装入 `i64`。
- `query(root,l,r)`：闭值域频次和。
- `kth(root,k)`：第 `k` 小的值域下标，排名从 1 开始，越界返回 `-1`；输出时映射回原值。
- `a=merge(a,b); b=0;`：破坏性合并，*两棵输入树不能共享节点*，主席树的版本不满足此要求。要保留子树答案，先记录再上交根。

点修改、区间查询、第 $k$ 小均为 $O(log M)$。设累计分配 $S$ 个节点、调用合并 $Q$ 次，全部合并 $O(S+Q)$；单次合并可为线性，因为双方非空的递归会消耗一个有效节点。

节点池不回收，空间 $O(S)$。递归分配时用下标访问 `vector`，避免保存跨扩容的引用；每次修改或合并都须保存返回根。

来源：wzj52501，#link("https://github.com/wzj52501/awesome-competitive-olympiad-algorithms/blob/c3685028be8ac258074260f8d8bd825faddc4a76/Lectures/Advanced-Data-Structures.pdf")[《高级数据结构》50–54 页]。说明文字 CC BY-NC-SA 4.0。

#code("数据结构与区间查询/值域结构合并（权值线段树合并）/权值线段树合并.cpp")


]
