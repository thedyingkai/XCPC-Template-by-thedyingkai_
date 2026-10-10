#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("括号合法性是路径不越界")] <trick-math-19>
*问题概述*　#text("给定 ")$n≥0$#text("，求长度 2n、恰有 ")$n$#text(" 个左括号和 ")$n$#text(" 个右括号的合法单类型括号串数量。每个前缀的左括号数必须不少于右括号数；")$n=0$#text(" 计唯一空串，不附加高度上界或括号颜色。")

*必要思路*　#text("")$n$#text(" 对括号数为 ")$binom(2n,n)-binom(2n,n+1)$#text("，用首次跌破边界的反射建立非法路径对应。需要多种括号颜色或高度上界时再加状态/限制。用差式计算可避免除以 ")$n+1$#text(" 在模数下不可逆的问题。")

*参考*　#link("https://cp-algorithms.com/combinatorics/catalan-numbers.html")[#text("CP-Algorithms：Catalan 数")]。



]
