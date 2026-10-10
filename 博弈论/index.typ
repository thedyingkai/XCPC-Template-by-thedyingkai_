#import "Nim 与无环游戏的 SG 模型/index.typ" as section-0
#import "反常终止（反 Nim）/index.typ" as section-1
#import "固定上限取石子（巴什）/index.typ" as section-2
#import "对称应手与策略偷换/index.typ" as section-3
#import "相邻层下移（阶梯 Nim）/index.typ" as section-4
#import "受阻棋子移动（Silver Dollar）/index.typ" as section-5
#import "双堆同步取石子（威佐夫）/index.typ" as section-6
#import "行动上限随步骤变化（Fibonacci Nim）/index.typ" as section-7
#import "可循环的胜负与平局（反图传播）/index.typ" as section-8
#import "双方规则不同的轮流博弈/index.typ" as section-9
#import "得分最大化对抗（minimax）/index.typ" as section-10
#import "树上删边游戏/index.typ" as section-11
#import "奇偶势与胜负规律证明/index.typ" as section-12

#let render(code) = [
#heading(level: 1, outlined: true)[博弈论] <chapter-game>

#text("除另述外，默认双方行动规则相同、轮流行动、无随机、有限结束、无法行动者输。反常终止、循环或共享资源需要单独建模。")

#text("每条先给明确问题模型，再给必要思路与适用条件。参考链接用于追溯知识，应用情景由本文重新整理。")


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

#section-10.render(code)

#section-11.render(code)

#section-12.render(code)

]
