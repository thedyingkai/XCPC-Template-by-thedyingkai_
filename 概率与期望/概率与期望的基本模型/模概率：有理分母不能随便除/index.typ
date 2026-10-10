#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("模概率：有理分母不能随便除")] <trick-math-32>
*问题概述*　#text("有限概率过程的转移概率为有理数 ")$a/b$#text("，题目要求把最终有理答案映射到模质数 ")$p$#text(" 的域中。要求原分母以及消元后真正需要求逆的分母都不为 0 mod p；求该模值，不能把浮点近似直接取模。")

*必要思路*　#text("若 ")$b$#text(" 在模 ")$p$#text(" 下可逆，表示为 ")$a op("inv")(b)$#text("，照样做代数递推；若 ")$b≡0 mod p$#text(" 或消自环出现不可逆分母，需要判断题目是否保证答案可定义，不能用浮点再取模。这里的模值不保留概率大小顺序。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/module-inverse.html")[#text("CP-Algorithms：模逆元")]。



]
