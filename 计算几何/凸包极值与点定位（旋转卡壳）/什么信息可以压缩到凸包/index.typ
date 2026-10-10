#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[什么信息可以压缩到凸包] <geom-hull-information>
凸包表示点集所有凸组合。若 $p=sum_i lambda_i p_i$，$lambda_i>=0$ 且 $sum_i lambda_i=1$，则对固定方向 $v$，

$ p dot.op v=sum_i lambda_i (p_i dot.op v)
  <=max_i (p_i dot.op v). $

固定方向的最小值同理；$v times p$ 也是线性函数。投影极值、支撑线、最远点对、最大面积三角形等可以把候选点限制在凸包上。最大三角形面积可固定另两个顶点后看第三点的线性叉积目标，再逐个替换到极点。

最近点对可能完全由内部点组成；点数、权重和、某类三角形数量也不由凸包决定。需要选内部点制造凹角时，应保留内部点集合，再对目标单独压缩。“外轮廓够用”要通过目标函数证明，不能看到点集就先删内部点。

板子的 `convexHull(points,false)` 返回不重复首点的逆时针严格凸包，删掉边上的共线中点；`true` 会保留共线边点。轮廓算法通常用前者，必须保留所有边界点编号的计数题用后者或另外存映射。全共线、单点、两点不是正面积多边形。



]
