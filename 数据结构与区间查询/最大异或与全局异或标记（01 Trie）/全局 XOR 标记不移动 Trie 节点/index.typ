#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("全局 XOR 标记不移动 Trie 节点")] <trick-bit-18>
*问题概述*　#text("维护 ")$W$#text(" 位非负整数多重集合，支持插入 ")$x$#text("、删除一份已存在的 ")$x$#text("、把全部现有元素同时 XOR K，以及给定 ")$x$#text(" 查询 ")$max_y(x op("xor") y)$#text("。查询时集合保证非空，插入删除的 ")$x$#text(" 都表示当时的真实数值。")

*必要思路*　#text("维护全局 tag，存底层值 ")$op("raw")=$#text("真实值 xor tag；全局修改只 ")$op("tag") op("xor")=K$#text("。查询真实 ")$x$#text(" 的最大异或等价查 raw 与 x xor tag。插入、删除都先翻译坐标；按真实数值排序则需按 tag 的各位解释 Trie 分支。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
