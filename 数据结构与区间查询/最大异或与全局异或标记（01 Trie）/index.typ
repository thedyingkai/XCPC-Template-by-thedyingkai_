#import "最大 XOR 与可任取子集 XOR 是两种问题/index.typ" as section-0
#import "全局 XOR 标记不移动 Trie 节点/index.typ" as section-1
#import "最高不同位决定 XOR 比较/index.typ" as section-2

#let render(code) = [
#heading(level: 2, outlined: true)[最大异或与全局异或标记（01 Trie）] <book-xor-trie>

维护非负整数的最大异或配对。当前处理第 `30..0` 位，单次插入、查询 $O(31)$；节点数最多与插入数量乘位数同阶。

`query(val)` 返回最大异或值，空 Trie 返回 0；若需配对原数，沿查询路径记录所选位。每位优先走相反分支；求最小异或改为优先相同分支。

*常用转换*　最大异或子段先插空前缀 0，再依次查询、插入当前前缀异或。树上根路径异或为 `sum[x]` 时，两点路径异或为 `sum[u] xor sum[v]`。

更大值域统一改 `u64`、最高位与移位常量。删除需加路径计数，查询仅走计数正的分支。随附树例使用显式栈。

题目：P4551。

#code("数据结构与区间查询/最大异或与全局异或标记（01 Trie）/01 Trie.cpp", mode: "full", ignore-main: false)


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

]
