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

#code("数据结构/并查集/按秩合并.cpp")

=== 带权并查集

#include "数据结构/并查集/带权并查集.typ"

#code("数据结构/并查集/带权并查集.cpp")

== 对顶堆

#code("数据结构/对顶堆/对顶堆.cpp")

== 树状数组

#code("数据结构/树状数组/树状数组.cpp", mode: "full", ignore-main: false)

== 线段树

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

== 线性基

#include "数据结构/线性基/线性基.typ"

#code("数据结构/线性基/线性基.cpp")


#pagebreak()

= 数学

== 快速幂

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

== 欧拉筛

=== 线性筛素数

#code("数学/欧拉筛/线性筛素数.cpp")

=== 线性筛积性函数

#code("数学/欧拉筛/线性筛积性函数.cpp")

== 整除分块

#code("数学/整除分块/整除分块.cpp", mode: "full")

== 扩展欧几里得

==== 求 $a x + b y = c$ 的解

#include "数学/扩展欧几里得/扩展欧几里得.typ"

#code("数学/扩展欧几里得/扩展欧几里得.cpp", mode: "full", ignore-main: false)

== 扩展欧拉定理

#include "数学/扩展欧拉定理/扩展欧拉定理.typ"

#code("数学/扩展欧拉定理/扩展欧拉定理.cpp", mode: "full")

== EXCRT

#include "数学/EXCRT/EXCRT.typ"

#code("数学/EXCRT/EXCRT.cpp", mode: "full")

== 线性代数

#code("数学/线性代数/线性代数.cpp")

== 高精度

=== 高精度加减乘除取余

#code("数学/高精度/高精度加减乘除取余.cpp")

=== 神秘题目

#code("数学/高精度/神秘题目.cpp", mode: "full")

== 康托展开

#code("数学/康托展开/康托展开.cpp")

== Lucas

#include "数学/Lucas/Lucas.typ"

#code("数学/Lucas/Lucas.cpp", mode: "full")

== 计算几何

#code("数学/计算几何/计算几何.cpp", mode: "full")

== 扫描线求矩阵面积并

#code("数学/扫描线求矩阵面积并/扫描线求矩阵面积并.cpp", mode: "full", ignore-main: false)

== EXBSGS

#include "数学/EXBSGS/EXBSGS.typ"

#code("数学/EXBSGS/EXBSGS.cpp", mode: "full")

== FFT

#code("数学/FFT/FFT.cpp", mode: "full", ignore-main: false)

== NTT

#code("数学/NTT/NTT.cpp", mode: "full", ignore-main: false)

== Pollard-Rho

#code("数学/Pollard-Rho/Pollard-Rho.cpp", mode: "full", ignore-main: false)


#pagebreak()

= 图论

== Dijkstra

#code("图论/Dijkstra/Dijkstra.cpp", mode: "full", ignore-main: false)

== Floyd

#code("图论/Floyd/Floyd.cpp")

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

== MST

#include "图论/MST/MST.typ"

=== 出圈法求最小生成树

#code("图论/MST/出圈法求最小生成树.cpp")

=== 出队法（Prim）

#code("图论/MST/出队法（Prim）.cpp")

=== 加边法（Kruskal）

#code("图论/MST/加边法（Kruskal）.cpp")

== 联通性问题

==== 通用概念

#include "图论/联通性问题/联通性问题.typ"

=== Tarjan SCC 缩点

#code("图论/联通性问题/Tarjan SCC 缩点.cpp")

=== Tarjan 求割点

#code("图论/联通性问题/Tarjan 求割点.cpp")

=== Tarjan 求割边（桥）

#code("图论/联通性问题/Tarjan 求割边（桥）.cpp")

=== eDCC 求边双

#code("图论/联通性问题/eDCC 求边双.cpp")

=== vDCC 求点双

#code("图论/联通性问题/vDCC 求点双.cpp")

== 网络流

#include "图论/网络流/网络流.typ"

=== EK 最大流

#code("图论/网络流/EK 最大流.cpp")

=== EK 最小费用最大流

#code("图论/网络流/EK 最小费用最大流.cpp")

=== Dinic 最大流最小割

#include "图论/网络流/Dinic 最大流最小割_2.typ"

#code("图论/网络流/Dinic 最大流最小割.cpp", mode: "full")

#include "图论/网络流/Dinic 最大流最小割_3.typ"

#code("图论/网络流/求最小割的划分_2.cpp", mode: "full")

#include "图论/网络流/Dinic 最大流最小割_4.typ"

#code("图论/网络流/求最小割的最少边数_3.cpp", mode: "full")

#code("图论/网络流/Dinic 最大流最小割_4.cpp", mode: "full")

=== Dinic 最小费用最大流

#code("图论/网络流/Dinic 最小费用最大流.cpp")

#pagebreak()

= 字符串

== Trie

=== 动态开点 Trie

#code("字符串/Trie/动态开点 Trie.cpp", mode: "full")

=== 01 Trie

#include "字符串/Trie/01 Trie.typ"

#code("字符串/Trie/01 Trie.cpp", mode: "full", ignore-main: false)

== KMP

#code("字符串/KMP/KMP.cpp", mode: "full", ignore-main: false)

== ACAM

#code("字符串/ACAM/ACAM.cpp", mode: "full", ignore-main: false)

== Manacher

#code("字符串/Manacher/Manacher.cpp", mode: "full")

== SAM

#code("字符串/SAM/SAM.cpp", mode: "full", ignore-main: false)

#pagebreak()

= 杂项

== 归并排序

#code("杂项/归并排序/归并排序.cpp")

== 三分

#code("杂项/三分/三分.cpp", mode: "full", ignore-main: false)

== i128 输入输出重载

#code("杂项/i128 输入输出重载/i128 输入输出重载.cpp", mode: "full")
