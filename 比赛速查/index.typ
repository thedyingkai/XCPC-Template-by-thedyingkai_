#import "算法名 → 页码索引/index.typ" as section-0

#let render(code) = [
#heading(level: 1, outlined: true, numbering: none)[比赛速查] <contest-lookup>
#text(weight: "bold")[题面信号 → 功能入口]

从题面信号定位条目，再核对该条适用条件。链接指向各章对应功能小节。

#table(columns: (1fr, 1fr, auto), table.header([题面信号], [优先尝试], [条目]),
[所有点在过定点直线一侧], [整数极角、同向分组、开闭半圆], [#link(<geom-half-plane>)[半圆扫描]],
[删点后不再包围观察点], [凸包外部与严格分离], [#link(<geom-separation>)[分离直线]],
[存在／任意朝向覆盖 k 点], [环形间隔差一个下标], [#link(<geom-coverage-width>)[覆盖角宽]],
[圆盘遮挡／固定半径覆盖点], [分别推 asin／acos 的半宽], [#link(<geom-circle-angle>)[圆的角区间]],
[无界变量满足最多线性约束], [正常数项消去，只保留方向], [#link(<geom-unbounded-scale>)[方向归约]],
[凸包插一点／最大面积凹包], [局部替边、空三角形或最小损失], [#link(<geom-local-hull>)[凸包修改]],
[固定方向上的投影极值], [支撑点、单调方向与卡壳], [#link(<geom-support>)[支撑函数]],
[很多凸多边形的面积总和], [有向边贡献、组合变换、卷积], [#link(<geom-edge-contribution>)[面积贡献]],
[随机方向／边界位置／区域点], [先确定角度、长度、面积测度], [#link(<geom-probability-measure>)[几何概率]],
[平移碰撞／平均重叠面积], [闵可夫斯基差可行域、交换积分], [#link(<geom-overlap-expectation>)[重叠期望]],
[随机配重改变面积重心], [仿射像与整体整数化], [#link(<geom-affine-centroid>)[随机重心]],
[整点反复取中点、要求最少步], [二进分母深度、倒推角点构造], [#link(<geom-midpoint>)[中点构造]],
[曼哈顿最远且切比雪夫最近], [直径下界、半开网格压候选], [#link(<geom-metrics>)[距离混合]],
[少量图形覆盖整个外框], [四角、极端点、固定见证集], [#link(<geom-finite-structure>)[有限结构]],
[反射到起点／第一次碰撞], [转角周期、阻挡树与凸链], [#link(<geom-reflection>)[反射]、#link(<geom-topology>)[拓扑]],
[#text("状态多了一维时间、历史费用")], [#text("把对未来已确定的费用提前结算")], [#link(<trick-dp-05>)[第 #context counter(page).at(<trick-dp-05>).first() 页]、#link(<trick-dp-06>)[第 #context counter(page).at(<trick-dp-06>).first() 页]],
[#text("容量特别大，但总价值小")], [#text("价值作下标，存最小重量")], [#link(<trick-dp-01>)[第 #context counter(page).at(<trick-dp-01>).first() 页]],
[#text("状态是“选了哪些”，还记人数")], [#text("人数可能等于集合大小")], [#link(<trick-dp-21>)[第 #context counter(page).at(<trick-dp-21>).first() 页]],
[#text("转移枚举连续区间、前一层求和")], [#text("前缀和或滑动最值")], [#link(<trick-dp-07>)[第 #context counter(page).at(<trick-dp-07>).first() 页]、#link(<trick-dp-08>)[第 #context counter(page).at(<trick-dp-08>).first() 页]],
[#text("转移含平方差或 i、j 乘积")], [#text("展开成直线，检查斜率与查询单调性")], [#link(<trick-dp-27>)[第 #context counter(page).at(<trick-dp-27>).first() 页]],
[#text("恰好 K 段，去掉次数限制后好做")], [#text("先验证离散凸性，再考虑 WQS")], [#link(<trick-dp-30>)[第 #context counter(page).at(<trick-dp-30>).first() 页]],
[#text("巨大值域的绝对值 DP")], [#text("分左右两侧，或凸分段线性维护")], [#link(<trick-dp-12>)[第 #context counter(page).at(<trick-dp-12>).first() 页]、#link(<trick-dp-31>)[第 #context counter(page).at(<trick-dp-31>).first() 页]],
[#text("网格窄、只与边界相邻")], [#text("轮廓/状压 DP")], [#link(<trick-dp-22>)[第 #context counter(page).at(<trick-dp-22>).first() 页]],
[#text("位数很多、数字范围极大")], [#text("数位 DP，记录必要性质")], [#link(<trick-dp-23>)[第 #context counter(page).at(<trick-dp-23>).first() 页]],
[#text("游戏分成互不影响的部分")], [#text("单游戏 SG，再异或")], [#link(<trick-game-06>)[第 #context counter(page).at(<trick-game-06>).first() 页]],
[#text("游戏可以循环、无限行动")], [#text("反图传播胜负平局")], [#link(<trick-game-14>)[第 #context counter(page).at(<trick-game-14>).first() 页]],
[#text("取最后一个者输")], [#text("单独分析反常末局")], [#link(<trick-game-03>)[第 #context counter(page).at(<trick-game-03>).first() 页]],
[#text("树上全点对总和")], [#text("按边或删点后分支算贡献")], [#link(<trick-tree-04>)[第 #context counter(page).at(<trick-tree-04>).first() 页]、#link(<trick-tree-20>)[第 #context counter(page).at(<trick-tree-20>).first() 页]],
[#text("每个点都作一次根")], [#text("换根消息，前后缀排除一个儿子")], [#link(<trick-tree-07>)[第 #context counter(page).at(<trick-tree-07>).first() 页]、#link(<trick-tree-08>)[第 #context counter(page).at(<trick-tree-08>).first() 页]],
[#text("每问只有少量关键点")], [#text("虚树或 DFS 序环上距离")], [#link(<trick-tree-12>)[第 #context counter(page).at(<trick-tree-12>).first() 页]、#link(<trick-tree-13>)[第 #context counter(page).at(<trick-tree-13>).first() 页]],
[#text("任意点到集合最远距离")], [#text("非负权树中的集合直径端点")], [#link(<trick-tree-09>)[第 #context counter(page).at(<trick-tree-09>).first() 页]、#link(<trick-tree-10>)[第 #context counter(page).at(<trick-tree-10>).first() 页]],
[#text("对所有子数组做 AND / OR / gcd")], [#text("固定端点压缩不同结果")], [#link(<trick-bit-13>)[第 #context counter(page).at(<trick-bit-13>).first() 页]、#link(<trick-math-10>)[第 #context counter(page).at(<trick-math-10>).first() 页]],
[#text("所有数对 XOR 总和")], [#text("每位数 ")$0/1$#text(" 对数")], [#link(<trick-bit-02>)[第 #context counter(page).at(<trick-bit-02>).first() 页]],
[#text("任意子集 XOR 是否可达")], [#text("线性基；别和“两原数”混淆")], [#link(<trick-bit-16>)[第 #context counter(page).at(<trick-bit-16>).first() 页]、#link(<trick-bit-17>)[第 #context counter(page).at(<trick-bit-17>).first() 页]],
[#text("掩码的全部子集之和")], [#text("SOS 高维前缀和")], [#link(<trick-bit-11>)[第 #context counter(page).at(<trick-bit-11>).first() 页]],
[#text("没有顺序但多次重复计数")], [#text("固定最小元素、唯一最高点或唯一最后一步")], [#link(<trick-dp-20>)[第 #context counter(page).at(<trick-dp-20>).first() 页]、#link(<trick-tree-15>)[第 #context counter(page).at(<trick-tree-15>).first() 页]],
[#text("区间和等于 K / 整除 m")], [#text("前缀值相等或同余")], [#link(<trick-misc-03>)[第 #context counter(page).at(<trick-misc-03>).first() 页]、#link(<trick-math-01>)[第 #context counter(page).at(<trick-math-01>).first() 页]],
[#text("期望是总得分或总数量")], [#text("指示变量逐对象算概率")], [#link(<trick-math-29>)[第 #context counter(page).at(<trick-math-29>).first() 页]],
[#text("求和含 floor(N/i)")], [#text("相同商分块")], [#link(<trick-math-07>)[第 #context counter(page).at(<trick-math-07>).first() 页]],
[#text("模数下公式有除法")], [#text("查 gcd，不能默认费马逆元")], [#link(<trick-math-04>)[第 #context counter(page).at(<trick-math-04>).first() 页]],
[#text("问答只看某个阈值")], [#text("排序激活、离线扫描")], [#link(<trick-misc-08>)[第 #context counter(page).at(<trick-misc-08>).first() 页]],
[#text("图上只有删除")], [#text("逆序加入")], [#link(<trick-misc-28>)[第 #context counter(page).at(<trick-misc-28>).first() 页]],
[#text("动态加入删除且可撤销")], [#text("对象活跃区间挂时间线段树")], [#link(<trick-misc-29>)[第 #context counter(page).at(<trick-misc-29>).first() 页]],
[#text("只有大约 40 个对象")], [#text("折半枚举")], [#link(<trick-misc-24>)[第 #context counter(page).at(<trick-misc-24>).first() 页]],
[#text("少数很大，多数很小")], [#text("推导高低频/高低度分治成本")], [#link(<trick-misc-25>)[第 #context counter(page).at(<trick-misc-25>).first() 页]、#link(<trick-misc-26>)[第 #context counter(page).at(<trick-misc-26>).first() 页]],
[#text("每次全部加一个相同值")], [#text("全局偏移")], [#link(<trick-misc-32>)[第 #context counter(page).at(<trick-misc-32>).first() 页]],
[#text("最少相邻交换")], [#text("逆序对或“位置减序号”")], [#link(<trick-misc-11>)[第 #context counter(page).at(<trick-misc-11>).first() 页]、#link(<trick-misc-12>)[第 #context counter(page).at(<trick-misc-12>).first() 页]],
)
#pagebreak()

#section-0.render(code)

]
