#import "隐藏模型与完成条件/index.typ" as section-0
#import "协议读写与预算管理/index.typ" as section-1
#import "直接构造合法见证/index.typ" as section-2
#import "构造单调判定与隔离干扰/index.typ" as section-3
#import "查询编码与线性信息恢复/index.typ" as section-4
#import "最坏询问次数与决策树/index.typ" as section-5
#import "有状态操作与未来可辨识性/index.typ" as section-6
#import "随机采样与周期识别/index.typ" as section-7
#import "博弈行动与守恒量/index.typ" as section-8
#import "题目索引与接口差异/index.typ" as section-9

#let render(code) = [
#pagebreak(weak: true)
#heading(level: 1, outlined: true)[交互题] <chapter-interactive>

从查询接口决定怎样取得信息：先明确完成条件和响应含义，再设计合法查询，证明每个分支的正确性与预算。差分、编码和随机采样可以叠加，各节按其解决的具体问题组织。

#table(columns: (1fr,1fr), table.header([要解决的问题], [功能入口]),
[回包不是想要的判定], [#link(<inter-predicate>)[构造谓词与隔离干扰]],
[一问含多个目标的信息], [#link(<inter-code>)[查询编码与线性恢复]],
[只能问很少次或先报最优次数], [#link(<inter-decision>)[下界与决策树]],
[操作移动、合并或删除对象], [#link(<inter-state>)[完整状态与未来实验]],
[随机方案需要硬查询上限], [#link(<inter-cycle>)[周期识别与失败概率]],
[每轮与对手轮流行动], [#link(<inter-game>)[博弈策略与守恒量]],
)

#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

#section-4.render(code)

#section-5.render(code)

#section-6.render(code)

#section-7.render(code)

#section-8.render(code)

#section-9.render(code)

#pagebreak(weak: true)
]
