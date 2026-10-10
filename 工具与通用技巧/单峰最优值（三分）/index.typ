#let render(code) = [
#heading(level: 2, outlined: true)[单峰最优值（三分）] <book-ternary-search>

`ternarySearch(l,r,f,eps)` 在已知单峰区间求近似极大点，极值再算 `f(x)`。当前为浮点最大化；求最小值反转比较。

端点须为有限 `double`，`eps>0`，默认 `1e-7`。区间足够短或浮点数已无法继续缩短时结束；分点用 `lerp`、结果用 `midpoint`，避免直接加减端点溢出。调用次数约 $O(log((r-l)/epsilon))$，总耗时乘单次求值成本。

需要更高精度时统一改 `long double`，也可固定迭代 100–200 次。整数自变量则三分缩到小区间后逐点枚举；平台要求特定最左、最右解时另定相等分支与最终选择。

题目：P3382、P1883。

#code("工具与通用技巧/单峰最优值（三分）/三分.cpp", mode: "full", ignore-main: false)


]
