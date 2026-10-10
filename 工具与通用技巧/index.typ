#import "带符号大整数运算/index.typ" as section-0
#import "宽整数运算与输入输出（i128）/index.typ" as section-1
#import "位枚举、进位与有限位域/index.typ" as section-2
#import "排序与逆序对（归并排序）/index.typ" as section-3
#import "单峰最优值（三分）/index.typ" as section-4
#import "指数规模搜索（折半）/index.typ" as section-5
#import "随机集合指纹/index.typ" as section-6
#import "连续区间可行性（双指针与单调队列）/index.typ" as section-7
#import "隐式第 k 小与第 k 大/index.typ" as section-8
#import "单调判定与比值最优（二分答案）/index.typ" as section-9
#import "截止时间调度与反悔贪心/index.typ" as section-10
#import "按中间元素统计三元组/index.typ" as section-11
#import "全点对绝对差总和（排序贡献）/index.typ" as section-12
#import "最少交换次数/index.typ" as section-13
#import "局部修改的增量维护/index.typ" as section-14
#import "区间选择中的支配删除/index.typ" as section-15
#import "不交叉区间构树/index.typ" as section-16
#import "高低频分治的总成本/index.typ" as section-17
#import "字典序最小的逐步构造/index.typ" as section-18
#import "MEX 的有效值域/index.typ" as section-19
#import "可达性不变量与最优下界构造/index.typ" as section-20
#import "稀疏事件跳过巨大时间轴/index.typ" as section-21
#import "随机对拍/index.typ" as section-22
#import "常见误用与适用条件/index.typ" as section-23

#let render(code) = [
#heading(level: 1, outlined: true)[工具与通用技巧] <chapter-tools>

#text("没有特定算法归属的技巧集中在这里。二分先证明单调，构造先证明可行；不变量只是必要条件时不能据此宣布可达。")

#text("每条先给明确问题模型，再给必要思路与适用条件。参考链接用于追溯知识，应用情景由本文重新整理。")

#text("默认非负或无符号整数，字长记为 W。ctz/clz 不可传 0，位移量必须小于类型宽度；计数和乘法先扩宽。")

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

#section-13.render(code)

#section-14.render(code)

#section-15.render(code)

#section-16.render(code)

#section-17.render(code)

#section-18.render(code)

#section-19.render(code)

#section-20.render(code)

#section-21.render(code)

#section-22.render(code)

#section-23.render(code)

]
