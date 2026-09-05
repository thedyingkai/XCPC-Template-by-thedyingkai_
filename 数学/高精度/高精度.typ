`Big` 表示超出内置整数范围的带符号十进制整数，提供比较、输入输出以及 `+ - * / %`。除法向零取整，余数与被除数同号，满足 `a = (a / b) * b + a % b`；同时需要商和余数时直接调用 `divmod(a,b)`，除数不得为零。

`Big.a` 平时以 $10^9$ 为基数保存绝对值，每块九位十进制数。位数较少时按竖式逐块相乘；位数较多时，临时拆成 $10^4$ 进制，用两个 NTT 模数卷积并经中国剩余定理精确恢复系数，最后转回 $10^9$ 进制。长乘不依赖浮点舍入，除法仍是二次量级。

长乘的第二个 NTT 模数只支持到 $2^21$ 点。设两数的十进制位数为 $d_1,d_2$，代码要求 `bit_ceil(ceil(d1 / 4) + ceil(d2 / 4) - 1) <= (1u << 21)`。等长输入时，每个数大约最多 419 万位；再大要更换第二模数或做分块卷积，否则会触发断言。只做模运算时不要先构造完整 `Big`，应在读字符串时滚动取模。它也不表示小数，带精度的小数运算应另定定点或浮点模型。

#link("https://judge.yosupo.jp/problem/addition_of_big_integers")[Library Checker · addition_of_big_integers]

#link("https://judge.yosupo.jp/problem/multiplication_of_big_integers")[Library Checker · multiplication_of_big_integers]
