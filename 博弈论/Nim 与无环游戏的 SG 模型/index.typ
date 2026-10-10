#import "先手必胜不是“可走步数为奇数”/index.typ" as section-0
#import "正常 Nim：寻找异或为零的局面/index.typ" as section-1
#import "减法游戏：有限窗口证明最终周期/index.typ" as section-2
#import "SG 合并：异或的是游戏，不是任意堆数/index.typ" as section-3
#import "分裂后继：先异或，再 mex/index.typ" as section-4
#import "mex 的范围由出度限制/index.typ" as section-5

#let render(code) = [
#heading(level: 2, outlined: true)[Nim 与无环游戏的 SG 模型] <book-sg>

*普通 Nim*　每步从一堆取任意正数，取最后者胜。`firstWinsNim` 判断堆大小异或和 s 是否非零；获胜操作选满足 `a[i] xor s < a[i]` 的堆，减到该值。

*反常 Nim*　取最后者输，初始非空：所有非空堆为 1 时，堆数偶数先手胜；存在大于 1 的堆时仍按异或和判胜负。当前全空接口返回 false，初始空局面按题意约定。

*SG*　无偏、正常规则、独立子游戏满足
$ g(u)=op("mex"){g(v) mid u->v}, $
终止值为 0，各子游戏 SG 异或后判零。状态必须无环或有严格下降量。

`subtractionGameSG(maxState,moves)` 预处理减法游戏，自动删非正、重复步长。图游戏先 `DAGSpragueGrundy sg(graph);`，再 `sg.get(u)`，点号 `0..graph.size()-1`；记忆化复用状态，发现递归环抛异常，深链需留意调用栈。

有偏、允许平局或一般反常规则另行分析。共享转移可复用预处理，观察到的周期须证明后用于远项。

题目：P2197、HDU1848。

#code("博弈论/Nim 与无环游戏的 SG 模型/SG 与 Nim.cpp", parts: ("nim", "subtraction-game", "dag-sg"))


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

#section-4.render(code)

#section-5.render(code)

]
