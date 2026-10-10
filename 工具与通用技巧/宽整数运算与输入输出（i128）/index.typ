#import "恒等式与宽整数防溢出/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[宽整数运算与输入输出（i128）] <book-wide-integer>

有符号 `i128` 的十进制流输入输出，可直接 `cin>>x`、`cout<<x`。范围为 $[-2^127,2^127-1]$，输出支持最小负数；输入须保证合法且不越界。当前没有 `u128` 重载。

乘法前扩宽：`(i128)a*b`；交叉相乘写 `(i128)a*b < (i128)c*d`。先在 `i64` 中计算再赋给 `i128` 无法补救溢出。`std::abs`、`std::to_string` 无对应重载，需另写。

题目：P1005。

#code("工具与通用技巧/宽整数运算与输入输出（i128）/i128 输入输出重载.cpp", mode: "full")


#section-0.render(code)

]
