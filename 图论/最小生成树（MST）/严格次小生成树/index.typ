#let render(code) = [
#heading(level: 3, outlined: true)[严格次小生成树] <book-variant-080>

求总权严格大于 MST 的最小生成树。`StrictSecondMST(n,edges)` 顶点 `1..n`、`n>=1`，无向边输入一次，支持负权、重边，自环忽略。

*取答案*　先判 `connected`；连通时 `mstWeight` 才有效。`secondWeight` 为空表示不存在严格次小树，合法权值可负，不能用 −1 代替无解。`treeEdges` 为当前 MST 的原边 0 下标。

*非树边替换*　对 `(u,v,w)` 查 MST 路径上最大值 `M1` 与严格次大值 `M2`：

- `w>M1`：删 `M1`，增加 `w-M1`。
- `w==M1` 且 `M2` 存在：删 `M2`，增加 `w-M2`。
- 无小于 `w` 的路径边：该边不给出严格增量。

两大值按不同权值保存，同值最大边不能充当 `M2`。缺失状态用 `count` 标记，真实边权可为 `LLONG_MIN`；差值先转 `i128` 再减，总权同类型。

时间 $O(m log m+(n+m)log n)$，空间 $O(m+n log n)$。三角形 `1,2,2` 的 MST 为 3、严格次小为 4；三边全 1 时无严格次小。

来源：本项目 MST 说明及 wzj52501 #link("https://github.com/wzj52501/awesome-competitive-olympiad-algorithms/blob/c3685028be8ac258074260f8d8bd825faddc4a76/Lectures/README.md")[课件次小生成树主题]。说明文字 CC BY-NC-SA 4.0。

#code("图论/最小生成树（MST）/严格次小生成树/严格次小生成树.cpp")


]
