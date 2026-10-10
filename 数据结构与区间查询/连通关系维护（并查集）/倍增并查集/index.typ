#import "只操作未处理位置：并查集跳过/index.typ" as section-0

#let render(code) = [
#heading(level: 3, outlined: true)[倍增并查集] <book-variant-004>

批量合并两个区间的对应位置。`RangeUnionDSU(n)` 使用 `1..n`，两区间须等长、同方向且在界内；允许重叠。$q$ 次操作总时间 $O((q+n log n) alpha(n))$，空间 $O(n log n)$。

- `uniteRanges(x,y,len)`：合并所有 `x+i` 与 `y+i`，其中 `0<=i<len`；`len=0` 不操作。
- `same(x,y)` 查询底层两点是否同集；`components` 是底层集合数。
- `uniteRanges(1,4,3)` 得到 `{1,4}`、`{2,5}`、`{3,6}` 三对关系，区间内部各点仍可属于不同集合。

*实现要点*　第 $k$ 层表示长度 $2^k$ 的块。两个块首次合并时递归合并左右半块，同层已同根就停止。任意长度取 `k=floor(log2(len))`，合并首尾两个长度 $2^k$ 的块即可；重叠约束可重复加入。

向下递归使用原区间起点，不能用并查集代表元替代。反向对应和树上路径对应须另行处理方向；“把区间内所有点连起来”不适用此接口。

来源：wzj52501，#link("https://github.com/wzj52501/awesome-competitive-olympiad-algorithms/blob/c3685028be8ac258074260f8d8bd825faddc4a76/Lectures/Rare-Tricks.pdf")[《隐秘的智慧》34–37 页]。说明文字 CC BY-NC-SA 4.0。

#code("数据结构与区间查询/连通关系维护（并查集）/倍增并查集/倍增并查集.cpp")


#section-0.render(code)

]
