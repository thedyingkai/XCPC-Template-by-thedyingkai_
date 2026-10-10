#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("WQS：把恰好 K 次变成惩罚次数")] <trick-dp-30>
*问题概述*　#text("给定一个按选择次数 ")$k$#text(" 分类的优化模型，")$F(k)$#text(" 是恰使用 ")$k$#text(" 次决策的最小原始代价，目标为 ")$F(K)$#text("。已知对任意惩罚 λ 可高效求 ")$min_k(F(k)+λ k)$#text(" 及对应次数；只有额外证明 ")$F$#text(" 的离散凸性或相应强对偶条件时，才要求从惩罚搜索恢复恰好 ")$K$#text(" 次的答案。")

*必要思路*　#text("每选一次加惩罚 λ，求 (代价,次数)，二分 λ 找次数跨越 ")$K$#text(" 的位置。同值时固定选更多或更少，保证实现的次数单调。仅有单调性不足以保证恢复恰好 ")$K$#text(" 的最优解，还需离散凸性或相应模型证明。")

*实现提示*　#text("这里只给惩罚参数搜索框架。check(lambda) 的转移、参数范围和答案恢复都由模型证明；计数会跳跃时，不能任取一个最优解再减 ")$op("lambda")*K$#text("。离散凸模型还须找到 ")$K$#text(" 对应的支撑参数。")

*伪代码*（需结合题目接口实现）

#trick-code("check(lambda):\n  solve unrestricted DP with each chosen part costing lambda\n  compare by (penalized_cost, -part_count)\n  return optimal (penalized_cost, part_count)\n\n// lambda grows -> returned part_count does not increase\n// choose lo,hi that bracket count K, proved from the model\nwhile lo < hi:\n  mid = floor((lo+hi)/2)\n  if check(mid).part_count <= K: hi = mid\n  else: lo = mid+1\n// inspect supporting parameter(s) near lo\n// recover F(K) only after proving strong duality for this model")

*参考*　#link("https://oi-wiki.org/dp/opt/wqs-binary-search/")[#text("OI Wiki：WQS 二分")]。



]
