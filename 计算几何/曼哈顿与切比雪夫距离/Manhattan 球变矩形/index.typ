#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("Manhattan 球变矩形")] <trick-math-24>
*问题概述*　#text("给定整数坐标点集及多组 ")$(x_0,y_0,R)$#text("，")$R≥0$#text("。对每组统计满足 ")$|x-x_0|+|y-y_0|≤R$#text(" 的输入点数量，边界计入，重复坐标按输入点的重数计。若改为统计全部整数格点，须另外保持坐标变换的奇偶约束。")

*必要思路*　#text("变换 ")$u=x+y$#text("、")$v=x-y$#text("，条件成 ")$|u-u_(0)|≤R$#text(" 且 ")$|v-v_(0)|≤R$#text("。点集查询可用二维前缀或扫描线；若要按变换后每个整数格点计数，原坐标为整数要求 ")$u$#text("、")$v$#text(" 同奇偶，不能把全部格点都算回去。")

*参考*　#link("https://cp-algorithms.com/geometry/manhattan-distance.html")[#text("CP-Algorithms：曼哈顿距离")]。



]
