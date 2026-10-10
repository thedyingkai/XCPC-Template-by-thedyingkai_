#let render(code) = [
#heading(level: 3, outlined: true)[Borůvka 异或最小生成树] <book-variant-079>

隐式完全图，边权 `a[u] xor a[v]`。`xorMST(a)` 接收完整 `u64` 点权，返回 `i128 weight` 与原数组 *0 下标* 边集。空图返回 0 和空边；非空返回 `n-1` 条边。

不同值数 $U$、有效位数 $B<=64$ 时，时间 $O(n log n+U B log U)$，空间 $O(n+U B)$。重复值先用零边接到代表点，再对不同值运行 Borůvka。

*每轮顺序*　固定当前并查集颜色，为 Trie 节点重算子树最小、最大颜色。查询异色最小异或时优先相同位；分支颜色最小、最大都等于本色则排除。每块选最小出边，全部查询完成后统一合并，同边或同权成环由并查集跳过。

查询期间保持颜色不变；边选完前合并会使 Trie 摘要过期。Trie 只建一次，叶子保存去重代表，返回边仍覆盖所有原点。

来源：wzj52501，#link("https://github.com/wzj52501/awesome-competitive-olympiad-algorithms/blob/c3685028be8ac258074260f8d8bd825faddc4a76/Lectures/Minimum-Spanning-Tree.pdf")[《最小生成树选讲》60–65 页]。说明文字 CC BY-NC-SA 4.0。

#code("图论/最小生成树（MST）/Borůvka 异或最小生成树/Boruvka 异或最小生成树.cpp", mode: "full")


]
