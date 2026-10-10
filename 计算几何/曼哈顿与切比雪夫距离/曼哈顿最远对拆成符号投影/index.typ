#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("曼哈顿最远对拆成符号投影")] <trick-math-23>
*问题概述*　#text("给定至少两个二维点，坐标可为负，求不同下标点对间曼哈顿距离 ")$|x_i-x_j|+|y_i-y_j|$#text(" 的最大值。允许点坐标重复；本条求最远距离，不求最近距离。")

*必要思路*　#text("看 ")$x+y$#text(" 与 x-y，两组各自最大值减最小值，取最大即可。")$d$#text(" 维推广为 ")$2^d$#text(" 个正负号投影，每种求极差。最远对可这样算，最近对不能简单取投影差最小值。")

*参考*　#link("https://cp-algorithms.com/geometry/manhattan-distance.html")[#text("CP-Algorithms：曼哈顿距离")]。



]
