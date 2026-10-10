#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("双指针成立的关键是合法性单调")] <trick-misc-05>
*问题概述*　#text("给定非负整数数组和 ")$K≥0$#text("，求元素和不超过 ")$K$#text(" 的非空连续子数组数量，等号计入。要求用左、右端点各不回退的窗口实现；如果输入允许负数，则必须更换算法而非继续沿用此单调性。")

*必要思路*　#text("非负数组扩大右端不会减小和，移左端不会增大和，才可单调推进。负数破坏性质，例如先超界后又合法；应改用前缀顺序统计等方法。先证明移动方向对条件的影响，再写尺取。")

*参考*　#link("https://oi-wiki.org/misc/two-pointer/")[#text("OI Wiki：双指针")]。



]
