#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[叉积与点积各自保留什么信息] <geom-cross-dot>
对非零向量 $u,v$，记从 $u$ 到 $v$ 的有向角为 $theta$：

$ u times v = |u| |v| sin theta, quad
  u dot.op v = |u| |v| cos theta. $

叉积为正表示 $v$ 在 $u$ 的严格左侧，对应逆时针转角在 $(0,pi)$；为负表示严格右侧。叉积为零只说明平行，还须看点积：正为同向，负为反向。点积为零表示垂直；点积正负分别区分锐角与钝角。

三个点的朝向用 $op("orient")(a,b,c)=(b-a) times (c-a)$。逆时针、顺时针、共线分别对应正、负、零。三角形两倍面积为其绝对值，点到直线距离为 $|(b-a) times (p-a)|/|b-a|$。比较距离时保留平方；比较两条等长底边上的三角形面积时直接比较叉积。

零向量的叉积与点积都为零，但它没有方向，不能由此宣称它与所有向量同向或垂直。需要方向的算法必须先剔除或单独计入零向量。



]
