#import "单进程函数对拍/index.typ" as section-0
#import "进程对拍/index.typ" as section-1

#let render(code) = [
#heading(level: 2, outlined: true)[随机对拍] <book-stress-test>

同一份小数据分别运行暴力与待提交代码，比较题目要求的答案。生成器覆盖最小规模、重复值、全相等、极值、空结构和随机操作；失配时保留种子与完整输入。

*函数对拍*　向 `Stress::run` 传 `generate(rng)`、`brute(case)`、`solve(case)`、`printCase`，默认用 `==` 比较。无序结果可用 `unorderedAnswer` 排序，浮点用 `close` 同时检查绝对与相对误差；多解题传自定义 `equal(expected,actual)` 检查可行性和目标值。

*进程对拍*　运行 `stress generator brute solve [tests]`。生成器从命令行读种子，三个程序均用标准输入输出；失配留下 `stress.in`、`stress.ans`、`stress.out`。默认逐 token 比较；浮点、无序答案、多解题需换 checker。崩溃和非零退出码单独报告，超时限制由外层进程设置。


#section-0.render(code)

#section-1.render(code)

]
