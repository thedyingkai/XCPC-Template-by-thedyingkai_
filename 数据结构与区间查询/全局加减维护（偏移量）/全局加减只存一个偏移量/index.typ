#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("全局加减只存一个偏移量")] <trick-misc-32>
*问题概述*　#text("维护整数多重集合，支持插入真实值 ")$x$#text("、删除一份存在的 ")$x$#text("、全部现有元素同时加 ")$d$#text("，以及查询最小真实值。重复值按重数处理，查询保证非空；整体操作只有加法，不包含乘负数或截断。")

*必要思路*　#text("维护 offset，实际值=底层值")$+op("offset")$#text("。插入 ")$x$#text(" 存 x-offset，整体加只改 offset，查询加回来。需要按阈值删除也先翻译阈值；整体乘负数、截断等操作会改顺序，不能只用偏移。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
