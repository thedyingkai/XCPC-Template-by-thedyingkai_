#let render(code) = [
#heading(level: 2, outlined: true)[多模式匹配（AC 自动机）] <book-ac>

小写字母的多模式出现次数，计入重叠匹配。模式总长 $M$、节点 $S$、文本总长 $N$ 时，时间 $O(M+26S+N)$，空间 $O(26S)$。

*调用顺序*　逐个 `insert(pattern,idx)`，保存引用参数写回的编号；全部插完后 `build()`，再 `query(text)`，最后只调用一次 `topu()`，从 `ac.ans[idx[i]]` 读各模式答案。

重复模式共用编号。多篇文本可连续 `query` 后统一汇总，每篇从根开始，跨篇不拼接。`topu` 会修改入度和计数；`build` 已将缺边补成自动机转移，此后不再插入，也不能将全部 `son` 当 Trie 孩子遍历。当前仅处理非空模式；累计计数超过 `int` 时同步改节点与输出类型。

*fail 与计数*　BFS 中，真实边 `u-c->v` 令 `fail[v]=go(fail[u],c)`，缺边补 `go(fail[u],c)`。扫描只给当前状态加一，再沿 fail 树从叶到根累加；终点的最终值即出现次数。

*改题常用操作*

- 禁串计数：BFS 传播 `bad[u]|=bad[fail[u]]`，DP 只进入非禁用状态；长度很大、状态少时转矩阵快速幂。
- 模式动态启停：fail 树上给终点子树加减，扫描到 `u` 时查 `dfn[u]` 单点。
- 每个文本位置匹配数：预处理 `out[u]=terminal[u]+out[fail[u]]`，扫描直接取 `out[u]`；重复模式是否多计由 `terminal` 决定。
- 模式 `a` 是 `b` 后缀：检查终点 `a` 是否为终点 `b` 在 fail 树上的祖先。

换字符集时同时改数组与映射。题目：P5357；#link("https://judge.yosupo.jp/problem/aho_corasick")[Aho–Corasick] 需另存 Trie 父亲、每个模式终点。

#code("字符串/多模式匹配（AC 自动机）/ACAM.cpp", mode: "full", ignore-main: false)


]
