#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("概率 DP：保存分布而非所有过程")] <trick-dp-17>
*问题概述*　#text("有 ")$n$#text(" 枚相互独立的硬币，第 ")$i$#text(" 枚出现正面的概率为 ")$p_i∈[0,1]$#text("。每枚恰抛一次，给定整数阈值 ")$0≤K≤n$#text("，求正面总数至少 ")$K$#text(" 的概率；各硬币的概率允许不同。")

*必要思路*　#text("")$op("dp")_(j)$#text(" 记当前恰好 ")$j$#text(" 个正面的概率，每枚用 ")$p$#text(" 和 ")$1-p$#text(" 转移。所有排列过程只通过正面数影响答案，因此可合并；一维倒序更新要同时保留原 ")$op("dp")_(j)$#text("。最终按题目阈值求和。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。



]
