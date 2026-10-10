#let render(code) = [
#heading(level: 2, outlined: true)[单词与前缀集合（Trie）] <book-string-trie>

小写字母前缀计数，插入和查询均 $O(|s|)$，空间按累计新建节点数算。节点 `count` 为经过它的字符串数，`prefix_count(s)` 返回此前缀的出现数；重复插入重复计，空前缀返回总数。

当前没有终止计数。查完整字符串时在终点增加 `end`；删除同时减少路径 `count` 与终点 `end`。换字符集同步改 `SZ` 与映射，节点多或多测时可改数组池。

题目 P8306 使用大小写字母和数字，须扩成 62 种字符并输出 `prefix_count`；当前示例 `main` 只输出节点数。每组结束释放所有 `new` 节点，或重置数组池，仅重建 `Trie` 对象不会释放旧节点。

#code("字符串/单词与前缀集合（Trie）/动态开点 Trie.cpp", mode: "full")

参见 #link(<book-xor-trie>)[整数异或查询的 01 Trie]。

#pagebreak()


]
