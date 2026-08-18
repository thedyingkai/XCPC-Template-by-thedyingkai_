#import "template/frame.typ": *

#set document(
  title: "XCPC 算法模板 by thedyingkai_",
  author: "thedyingkai_",
  date: auto
)

#set page(
  paper: "a4",
  margin: (x: 1.5cm, y: 2.5cm)
)

#set text(
  font: ("Times New Roman", "Microsoft YaHei"), 
  size: 10.5pt
)

#show heading.where(level: 1): set heading(numbering: "第一章")
#set heading(numbering: "1.1")
#show heading.where(level: 4): set heading(numbering: none)

#include "template/cover.typ"


#let old_page = context {
  counter(page).get().first()
}
#context counter(page).update(1);

#set page(
  numbering: "1",
  header: context(header(here().page())),
  footer: footer
)

= 数据结构

== 并查集

=== 按秩合并

#include "数据结构/并查集/按秩合并.typ"

#code("数据结构/并查集/按秩合并.cpp")

=== 带权并查集

#include "数据结构/并查集/带权并查集.typ"

#code("数据结构/并查集/带权并查集.cpp")

=== 可撤销并查集

#include "数据结构/并查集/可撤销并查集.typ"

#code("数据结构/并查集/可撤销并查集.cpp")

== 对顶堆

#include "数据结构/对顶堆/对顶堆.typ"

#code("数据结构/对顶堆/对顶堆.cpp")

== 树状数组

#include "数据结构/树状数组/树状数组.typ"

#code("数据结构/树状数组/树状数组.cpp", mode: "full", ignore-main: false)

== 稀疏表

#include "数据结构/稀疏表/稀疏表.typ"

#code("数据结构/稀疏表/稀疏表.cpp", parts: ("sparse-table", "disjoint-sparse-table"))

== 线段树

#include "数据结构/线段树/线段树.typ"

=== 维护区间和，支持区间加、区间查询

#code("数据结构/线段树/维护区间和，支持区间加、区间查询.cpp", mode: "full", ignore-main: false)

=== 维护区间最大值，支持区间加、区间查询

#code("数据结构/线段树/维护区间最大值，支持区间加、区间查询.cpp", mode: "full", ignore-main: false)

=== 维护区间和，支持区间加、区间乘、区间查询

#code("数据结构/线段树/维护区间和，支持区间加、区间乘、区间查询.cpp", mode: "full", ignore-main: false)

=== 动态开点，维护区间和，支持区间加、区间查询

#code("数据结构/线段树/动态开点，维护区间和，支持区间加、区间查询.cpp", mode: "full", ignore-main: false)

=== 维护区间 GCD，支持区间加、区间查询

#code("数据结构/线段树/维护区间 GCD，支持区间加、区间查询.cpp", mode: "full", ignore-main: false)

== 主席树

#include "数据结构/主席树/主席树.typ"

#code("数据结构/主席树/主席树.cpp")

== 李超树

#include "数据结构/李超树/李超树.typ"

#code("数据结构/李超树/李超树.cpp")

== 平衡树

=== FHQ Treap

#include "数据结构/平衡树/FHQ Treap.typ"

#code("数据结构/平衡树/FHQ Treap.cpp")

== 动态树

=== Link-Cut Tree

#include "数据结构/动态树/Link-Cut Tree.typ"

#code("数据结构/动态树/Link-Cut Tree.cpp")

=== Euler Tour Tree

#include "数据结构/动态树/Euler Tour Tree.typ"

#code("数据结构/动态树/Euler Tour Tree.cpp")

=== 静态拓扑 Top Tree

#include "数据结构/动态树/Top Tree/静态拓扑 Top Tree.typ"

#code("数据结构/动态树/Top Tree/静态拓扑 Top Tree.cpp")

== 莫队

#include "数据结构/莫队/莫队.typ"

#code("数据结构/莫队/莫队.cpp")

=== Hilbert 序莫队

#include "数据结构/莫队/Hilbert 序莫队.typ"

#code("数据结构/莫队/Hilbert 序莫队.cpp")

== 离线扫描

#include "数据结构/离线扫描/离线扫描.typ"

#code("数据结构/离线扫描/区间不同数.cpp")

== CDQ 分治

#include "数据结构/CDQ 分治/CDQ 三维偏序.typ"

#code("数据结构/CDQ 分治/CDQ 三维偏序.cpp")

== 整体二分

#include "数据结构/整体二分/动态区间第 k 小.typ"

#code("数据结构/整体二分/动态区间第 k 小.cpp")

== 根号分治

#include "数据结构/根号分治/图上邻居加.typ"

#code("数据结构/根号分治/图上邻居加.cpp")

== 动态位集

#include "数据结构/动态位集/动态位集.typ"

#code("数据结构/动态位集/动态位集.cpp")

== 线性基

#include "数据结构/线性基/线性基.typ"

#code("数据结构/线性基/线性基.cpp")


#pagebreak()


= 数学

== 快速幂

#include "数学/快速幂/快速幂.typ"

=== 普通快速幂

#code("数学/快速幂/普通快速幂.cpp", mode: "full")

=== 快速乘

#include "数学/快速幂/快速乘.typ"

#code("数学/快速幂/快速乘.cpp", mode: "full")

=== 龟速乘

#include "数学/快速幂/龟速乘.typ"

#code("数学/快速幂/龟速乘.cpp", mode: "full")

=== 矩阵快速幂

#code("数学/快速幂/矩阵快速幂.cpp")

== 扩展欧几里得

==== 求 $a x + b y = c$ 的解

#include "数学/扩展欧几里得/扩展欧几里得.typ"

#code("数学/扩展欧几里得/扩展欧几里得.cpp", mode: "full", ignore-main: false)

== EXCRT

#include "数学/EXCRT/EXCRT.typ"

#code("数学/EXCRT/EXCRT.cpp", mode: "full")

== 扩展欧拉定理

#include "数学/扩展欧拉定理/扩展欧拉定理.typ"

#code("数学/扩展欧拉定理/扩展欧拉定理.cpp", mode: "full")

== EXBSGS

#include "数学/EXBSGS/EXBSGS.typ"

#code("数学/EXBSGS/EXBSGS.cpp", mode: "full")

== 欧拉筛

#include "数学/欧拉筛/欧拉筛.typ"

=== 线性筛素数

#code("数学/欧拉筛/线性筛素数.cpp")

=== 线性筛积性函数

#code("数学/欧拉筛/线性筛积性函数.cpp")

== Pollard-Rho

#include "数学/Pollard-Rho/Pollard-Rho.typ"

#code("数学/Pollard-Rho/Pollard-Rho.cpp", mode: "full", ignore-main: false)


#pagebreak()

== 整除分块

#include "数学/整除分块/整除分块.typ"

#code("数学/整除分块/整除分块.cpp", mode: "full")

== 莫比乌斯反演

#include "数学/莫比乌斯反演/莫比乌斯反演.typ"

== 杜教筛

#include "数学/杜教筛/杜教筛.typ"

#code("数学/杜教筛/杜教筛.cpp")

== Min_25 筛

#include "数学/Min_25 筛/Min_25 筛.typ"

#code("数学/Min_25 筛/Min_25 筛.cpp")

== 类欧几里得

=== floor_sum

#include "数学/类欧几里得/floor_sum.typ"

#code("数学/类欧几里得/floor_sum.cpp", mode: "full")

=== 高阶类欧（精确值）

#include "数学/类欧几里得/高阶类欧.typ"

#code("数学/类欧几里得/高阶类欧.cpp", mode: "full")

=== 高阶类欧（取模）

#include "数学/类欧几里得/高阶类欧取模.typ"

#code("数学/类欧几里得/高阶类欧取模.cpp", mode: "full")

== 线性代数

=== 矩阵运算与快速幂

#include "数学/线性代数/矩阵运算.typ"

#code("数学/线性代数/矩阵运算.cpp")

=== 高斯消元

#include "数学/线性代数/高斯消元.typ"

#code("数学/线性代数/高斯消元.cpp", mode: "full")

=== 行列式、逆矩阵与线性方程组

#include "数学/线性代数/线性代数.typ"

#code("数学/线性代数/线性代数.cpp", parts: ("determinant", "inverse", "solve-linear"))

== 高精度

#include "数学/高精度/高精度.typ"

=== 高精度加减乘除取余

#code("数学/高精度/高精度加减乘除取余.cpp")

=== 神秘题目

#code("数学/高精度/神秘题目.cpp", mode: "full")

== 组合数

#include "数学/组合数/组合数.typ"

#code("数学/组合数/组合数.cpp", parts: ("comb", "batch-inverse"))

== Lucas

#include "数学/Lucas/Lucas.typ"

#code("数学/Lucas/Lucas.cpp", mode: "full")

== 任意模组合数

#include "数学/任意模组合数/任意模组合数.typ"

#code("数学/任意模组合数/任意模组合数.cpp")

== 组合计数

#include "数学/组合计数/组合计数.typ"

#code("数学/组合计数/组合计数.cpp", parts: ("partition-numbers", "common-numbers"))

== 康托展开

#include "数学/康托展开/康托展开.typ"

#code("数学/康托展开/康托展开.cpp")

== Burnside 与 Pólya

#include "数学/Burnside 与 Pólya/Burnside 与 Pólya.typ"

== 概率与期望

#include "数学/概率与期望/概率与期望.typ"

== SG 与 Nim

#include "数学/SG 与 Nim/SG 与 Nim.typ"

#code("数学/SG 与 Nim/SG 与 Nim.cpp", parts: ("nim", "subtraction-game", "dag-sg"))

== 生成函数

#include "数学/生成函数/生成函数.typ"

== FFT

#include "数学/FFT/FFT.typ"

#code("数学/FFT/FFT.cpp", mode: "full", ignore-main: false)

== NTT

#include "数学/NTT/NTT.typ"

#code("数学/NTT/NTT.cpp", mode: "full", ignore-main: false)

== 集合变换

=== Zeta、Möbius 与快速沃尔什变换

#include "数学/集合变换/集合变换.typ"

#code("数学/集合变换/集合变换.cpp")

=== 子集卷积

#include "数学/集合变换/子集卷积.typ"

#code("数学/集合变换/子集卷积.cpp")

== 多项式

=== 基础运算与 NTT

#include "数学/多项式/多项式基础.typ"

#code("数学/多项式/多项式基础.cpp", mode: "full")

=== 多项式求逆

#include "数学/多项式/多项式求逆.typ"

#code("数学/多项式/多项式求逆.cpp", mode: "full")

=== 多项式对数与指数

#include "数学/多项式/多项式对数与指数.typ"

#code("数学/多项式/多项式对数与指数.cpp", mode: "full")

=== 多项式平方根

#include "数学/多项式/多项式平方根.typ"

#code("数学/多项式/多项式平方根.cpp", mode: "full")

=== 多项式除法

#include "数学/多项式/多项式除法.typ"

#code("数学/多项式/多项式除法.cpp", mode: "full")

=== 多项式幂

#include "数学/多项式/多项式幂.typ"

#code("数学/多项式/多项式幂.cpp", mode: "full")

=== 多点求值与插值

#include "数学/多项式/多点求值与插值.typ"

#code("数学/多项式/多点求值与插值.cpp", mode: "full")

== 拉格朗日插值

#include "数学/拉格朗日插值/拉格朗日插值.typ"

#code("数学/拉格朗日插值/拉格朗日插值.cpp", mode: "full")

== 线性递推

=== Berlekamp–Massey

#include "数学/线性递推/Berlekamp-Massey.typ"

#code("数学/线性递推/Berlekamp-Massey.cpp")

=== Bostan–Mori

#include "数学/线性递推/Bostan-Mori.typ"

#code("数学/线性递推/Bostan-Mori.cpp", mode: "full")

== 计算几何

=== 点与直线基础

#include "数学/计算几何/点与直线基础.typ"

#code("数学/计算几何/点与直线基础.cpp", mode: "full")

=== 线段与多边形

#include "数学/计算几何/线段与多边形.typ"

#code(
  "数学/计算几何/线段与多边形.cpp",
  parts: ("point-in-polygon", "segment-intersection", "segment-in-polygon"),
)

=== 半平面交

#include "数学/计算几何/半平面交.typ"

#code("数学/计算几何/半平面交.cpp", mode: "full")

=== 凸包与旋转卡壳

#include "数学/计算几何/凸包与旋转卡壳.typ"

#code("数学/计算几何/凸包与旋转卡壳.cpp", parts: ("convex-hull", "diameter"))

=== 圆

#include "数学/计算几何/圆.typ"

#code("数学/计算几何/圆.cpp", parts: ("circle-base", "intersections", "tangents", "intersection-area"))

=== 扫描线求矩形面积并

#include "数学/计算几何/扫描线求矩形面积并/扫描线求矩形面积并.typ"

#code("数学/计算几何/扫描线求矩形面积并/扫描线求矩形面积并.cpp", mode: "full", ignore-main: false)


= 图论

== Dijkstra

#include "图论/Dijkstra/Dijkstra.typ"

#code("图论/Dijkstra/Dijkstra.cpp", mode: "full", ignore-main: false)

== Floyd

#include "图论/Floyd/Floyd.typ"

#code("图论/Floyd/Floyd.cpp")

== 差分约束

#include "图论/差分约束/差分约束.typ"

#code("图论/差分约束/差分约束.cpp")

== 树上常用公式

#include "图论/树上常用公式/树上常用公式.typ"

== LCA

==== 四种 LCA 求法

#include "图论/LCA/LCA.typ"

=== 倍增求 LCA

#code("图论/LCA/倍增求 LCA.cpp")

=== Tarjan 求 LCA

#code("图论/LCA/Tarjan 求 LCA.cpp")

=== 树链剖分求 LCA

#code("图论/LCA/树链剖分求 LCA.cpp")

=== RMQ 欧拉序求 LCA

#code("图论/LCA/RMQ 欧拉序求 LCA.cpp")

== 树链剖分

#include "图论/树链剖分/树链剖分.typ"

#code("图论/树链剖分/树链剖分.cpp")

== 虚树

#include "图论/虚树/虚树.typ"

#code("图论/虚树/虚树.cpp")

== Prüfer 序列

#include "图论/Prüfer 序列/Prüfer 序列.typ"

#code("图论/Prüfer 序列/Prüfer 序列.cpp", parts: ("heap", "linear"))

== 功能图

#include "图论/功能图/功能图.typ"

#code("图论/功能图/功能图.cpp")

== 无向基环树

#include "图论/基环树/无向基环树.typ"

#code("图论/基环树/无向基环树.cpp")

== MST

#include "图论/MST/MST.typ"

=== 出圈法求最小生成树

#code("图论/MST/出圈法求最小生成树.cpp")

=== 出队法（Prim）

#code("图论/MST/出队法（Prim）.cpp")

=== 加边法（Kruskal）

#code("图论/MST/加边法（Kruskal）.cpp")

== Kruskal 重构树

#include "图论/Kruskal 重构树/Kruskal 重构树.typ"

#code("图论/Kruskal 重构树/Kruskal 重构树.cpp")

== 矩阵树定理

#include "图论/矩阵树定理/矩阵树定理.typ"

#code("图论/矩阵树定理/矩阵树定理.cpp")

== 联通性问题

==== 通用概念

#include "图论/联通性问题/联通性问题.typ"

#include "图论/联通性问题/割点、桥与双连通分量.typ"

=== Tarjan SCC 缩点

#include "图论/联通性问题/Tarjan SCC 缩点.typ"

#code("图论/联通性问题/Tarjan SCC 缩点.cpp")

=== Tarjan 求割点

#code("图论/联通性问题/Tarjan 求割点.cpp")

=== Tarjan 求割边（桥）

#code("图论/联通性问题/Tarjan 求割边（桥）.cpp")

=== eDCC 求边双

#code("图论/联通性问题/eDCC 求边双.cpp")

=== vDCC 求点双

#code("图论/联通性问题/vDCC 求点双.cpp")

== 2-SAT

#include "图论/2-SAT/2-SAT.typ"

#code("图论/2-SAT/2-SAT.cpp")

== 支配树

#include "图论/支配树/支配树.typ"

#code("图论/支配树/支配树.cpp")

== 欧拉路

#include "图论/欧拉路/欧拉路.typ"

#code("图论/欧拉路/欧拉路.cpp")

== 线段树分治

#include "图论/线段树分治/线段树分治.typ"

#code("图论/线段树分治/线段树分治.cpp")

== 二分图匹配

#include "图论/二分图匹配/二分图最大匹配.typ"

#code("图论/二分图匹配/二分图最大匹配.cpp")

== 一般图最大匹配

#include "图论/一般图匹配/一般图最大匹配.typ"

#code("图论/一般图匹配/一般图最大匹配.cpp")

== 拟阵交

#include "图论/拟阵交/拟阵交.typ"

=== 增广框架

#code("图论/拟阵交/拟阵交.cpp", mode: "full")

=== 划分拟阵与图拟阵

#code("图论/拟阵交/常用拟阵.cpp", parts: ("partition-matroid", "graphic-matroid"))

== 网络流

#include "图论/网络流/网络流.typ"

=== EK 最大流

#include "图论/网络流/EK 最大流.typ"

#code("图论/网络流/EK 最大流.cpp")

=== EK 最小费用最大流

#include "图论/网络流/EK 最小费用最大流.typ"

#code("图论/网络流/EK 最小费用最大流.cpp")

=== Dinic 最大流最小割

#include "图论/网络流/Dinic 最大流最小割_2.typ"

#code("图论/网络流/Dinic 最大流最小割.cpp", mode: "full")

#include "图论/网络流/Dinic 最大流最小割_3.typ"

#code("图论/网络流/求最小割的划分_2.cpp", mode: "full")

#include "图论/网络流/Dinic 最大流最小割_4.typ"

#code("图论/网络流/求最小割的最少边数_3.cpp", mode: "full")

=== Dinic 最小费用最大流

#include "图论/网络流/Dinic 最小费用最大流.typ"

#code("图论/网络流/Dinic 最小费用最大流.cpp")

=== 有上下界可行流

#include "图论/网络流/有上下界可行流.typ"

#code("图论/网络流/有上下界可行流.cpp")

#pagebreak()


= 字符串

== 字符串哈希

#include "字符串/字符串哈希/字符串哈希.typ"

#code("字符串/字符串哈希/字符串哈希.cpp")

== KMP

#include "字符串/KMP/KMP.typ"

#code("字符串/KMP/KMP.cpp", mode: "full", ignore-main: false)

== Z 函数

#include "字符串/Z 函数/Z 函数.typ"

#code("字符串/Z 函数/Z 函数.cpp", mode: "full")

== Trie

=== 动态开点 Trie

#include "字符串/Trie/动态开点 Trie.typ"

#code("字符串/Trie/动态开点 Trie.cpp", mode: "full")

=== 01 Trie

#include "字符串/Trie/01 Trie.typ"

#code("字符串/Trie/01 Trie.cpp", mode: "full", ignore-main: false)

== ACAM

#include "字符串/ACAM/ACAM.typ"

#code("字符串/ACAM/ACAM.cpp", mode: "full", ignore-main: false)

== Manacher

#include "字符串/Manacher/Manacher.typ"

#code("字符串/Manacher/Manacher.cpp", mode: "full")

== 后缀数组与 LCP

#include "字符串/后缀数组/后缀数组.typ"

#code("字符串/后缀数组/后缀数组.cpp")

== SAM

#include "字符串/SAM/SAM.typ"

#code("字符串/SAM/SAM.cpp", mode: "full", ignore-main: false)

== Lyndon 分解

#include "字符串/Lyndon 分解/Lyndon 分解.typ"

#code("字符串/Lyndon 分解/Lyndon 分解.cpp")

== 极大周期串（runs）

#include "字符串/runs/runs.typ"

#code("字符串/runs/runs.cpp")

#pagebreak()


= 杂项

== 归并排序

#include "杂项/归并排序/归并排序.typ"

#code("杂项/归并排序/归并排序.cpp")

== 三分

#include "杂项/三分/三分.typ"

#code("杂项/三分/三分.cpp", mode: "full", ignore-main: false)

== 折半搜索

#include "杂项/折半搜索/折半搜索.typ"

#code("杂项/折半搜索/折半搜索.cpp")

== 随机指纹

#include "杂项/随机指纹/随机指纹.typ"

#code("杂项/随机指纹/随机指纹.cpp")

== i128 输入输出重载

#include "杂项/i128 输入输出重载/i128 输入输出重载.typ"

#code("杂项/i128 输入输出重载/i128 输入输出重载.cpp", mode: "full")
