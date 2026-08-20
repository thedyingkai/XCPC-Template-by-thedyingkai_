欧拉路径要求每条边恰好使用一次，输出经过的顶点序列；首尾相同就是欧拉回路。一次走完全部道路、把若干带首尾状态的物品排成一列、按字符串前后缀拼接，都可把状态看成点、物品看成边后求欧拉路。它使用每条“边”一次，不是访问每个“点”一次的哈密顿路。

有向图存在开口欧拉路径时，起点出度比入度多 $1$，终点入度比出度多 $1$，其余点平衡；欧拉回路则全部平衡。无向图相应要求恰有两个奇度点或没有奇度点。度数条件还不够，所有非孤立边必须落在从所选起点能走到的同一部分；本板在 Hierholzer 算法结束后检查是否恰好使用了 `m` 条边，统一完成这项判定。

Hierholzer 沿尚未使用的边一直走，走不动时把当前点加入答案并回退。每条边只被跳过或使用一次，逆序后的回退序列就是欧拉路，复杂度为 $O(n+m)$。无向边的两个邻接项共用同一个边编号，才能保证只使用一次。

`Euler(n,true)` 建有向图，`Euler(n,false)` 建无向图；无向边只调用一次 `add`。`trail()` 自动选择合法起点，`trail(start)` 强制起点；成功返回 `m+1` 个点，否则返回空数组。要输出边编号或标签，就在栈中同时保存进入当前点的边；要字典序最小，先按另一端点排序邻接表，并在有两个起点时显式选择较小者。

#link("https://judge.yosupo.jp/problem/eulerian_trail_directed")[Library Checker · Eulerian Trail Directed]

#link("https://judge.yosupo.jp/problem/eulerian_trail_undirected")[Library Checker · Eulerian Trail Undirected]
