#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("尾和公式：期望长度换存活概率")] <trick-math-30>
*问题概述*　#text("给定取值于非负整数的随机变量 ")$X$#text("，能够计算每个 ")$k≥1$#text(" 的 ")$P(X≥k)$#text("，但难以直接计算 ")$P(X=k)$#text("。求 ")$E_(X)$#text("；如果支撑集无限，期望允许为无穷，必须根据尾概率和判断是否收敛。")

*必要思路*　#text("")$X= sum _(k≥1)[X≥k]$#text("，因此 ")$E_(X)= sum  P(X≥k)$#text("。比如最长连续成功长度、等待轮数可从前缀事件得到。无限和要确认收敛；几何等待以成功概率 p>0 为例 ")$E=1/p$#text("。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
