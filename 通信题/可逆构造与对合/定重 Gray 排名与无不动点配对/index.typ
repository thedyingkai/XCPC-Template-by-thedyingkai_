#let render(code) = [
#heading(level: 3, outlined: true)[定重 Gray 排名与无不动点配对] <comm-gray>

同一函数每次移动一件家具，两次后恢复。将 n 个格子的占用视为恰有 k 个 1 的串，需 $f(f(s))=s$ 且 $f(s)!=s$，每步交换一个 0 与一个 1。

状态数 $binom(n,k)$ 为奇数则无法两两配对。偶数时，用定重 Gray 顺序 G(n,k)，递归为“0 接 G(n-1,k)”后接“1 接反序 G(n-1,k-1)”。相邻状态相差一次 0／1 交换；反序的是列表次序，不是每个串的位序。

令 R 为该顺序的精确排名，取 $f(s)=op("unrank")(op("rank")(s) ⊕ 1)$。偶数长度列表使偶奇相邻序号成对，不越界；再次异或 1 复原。组合数奇偶满足 $binom(n,k)$ 为奇数当且仅当 $(k " AND " (n-k))=0$，可整数判断。

代码依赖 #raw("#include <boost/multiprecision/cpp_int.hpp>")，用 cpp_int 保持排名精确，按每个前缀的组合数计算当前块长，不枚举所有状态。大整数成本仍需与原题规模核对；普通二进制 Gray 序不保持重量，不能替代。#link("https://qoj.ac/problem/15636")[NWERC 2025 H 原题]。

#code("通信题/可逆构造与对合/定重 Gray 排名与无不动点配对/定重 Gray 对合.cpp", mode: "full")
]
