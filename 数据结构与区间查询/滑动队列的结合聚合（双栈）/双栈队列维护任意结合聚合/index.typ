#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("双栈队列维护任意结合聚合")] <trick-misc-30>
*问题概述*　#text("维护先进先出队列，支持尾部加入、头部移除以及从队首到队尾依序聚合全部元素。聚合运算 op 满足结合律且有单位元 ")$e$#text("，但不要求交换律或逆元；空队列查询返回 ")$e$#text("，移除保证队列非空。")

*必要思路*　#text("入栈和出栈各维护前缀聚合，出栈为空就把入栈倒过去。每元素只搬有限次，均摊 ")$O(1)$#text(" 次合并。非交换运算须让出栈聚合从队首到中间、入栈从中间到队尾，再按顺序合并；不要求逆元。")

*实现提示*　#text("op 是结合运算，")$e$#text(" 是单位元。聚合方向覆盖矩阵乘法等非交换运算；空栈聚合取 ")$e$#text("。每个元素最多从 in 搬到 out 一次，均摊 ")$O(1)$#text(" 次 op。")

*伪代码*（需结合题目接口实现）

#trick-code("push(x):\n  in.push((x, op(in.aggregate_or(e), x)))\npop():\n  if out is empty:\n    while in not empty:\n      x = in.pop().value\n      out.push((x, op(x, out.aggregate_or(e))))\n  assert out not empty\n  out.pop()\nquery():\n  return op(out.aggregate_or(e), in.aggregate_or(e))")

*参考*　#link("https://cp-algorithms.com/data_structures/stack_queue_modification.html")[#text("CP-Algorithms：双栈与最小队列")]。



]
