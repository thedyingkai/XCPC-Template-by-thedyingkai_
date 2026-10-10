#import "折半枚举：两个指数各小一半/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[指数规模搜索（折半）] <book-meet-in-middle>

约 40 个元素时，分别枚举两半子集，再排序配对，空间 $O(2^(n/2))$。本板含最大受限子集和、受限子集计数、最大独立集。

*子集和*　允许负数，包含空集；最大和接口在无可行子集时返回空。计数按子集计，同和的不同子集分别保留。各半边和及答案须装入 `i64`。排序与逐项二分的时间为 $O(n 2^(n/2))$；求精确和可改双指针或哈希，求方案另存掩码。

*最大独立集*　至多 40 点，`adjacency` 必须是无自环、对称的简单图。右半对所有掩码预处理其中的最大独立子集；枚举左半独立子集，删除右半相邻点后查表。时间 $O(n 2^(n/2))$，其中 $n$ 来自子集 DP。

题目：ABC184 F、CSES 1628；#link("https://judge.yosupo.jp/problem/maximum_independent_set")[Maximum Independent Set]。

#code("工具与通用技巧/指数规模搜索（折半）/折半搜索.cpp")


#section-0.render(code)

]
