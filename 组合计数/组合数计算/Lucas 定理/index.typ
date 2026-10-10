#let render(code) = [
#heading(level: 3, outlined: true)[Lucas 定理] <book-variant-169>

质数模 p 下，大组合数按 p 进制逐位拆分：
$ binom(n,k) equiv product_i binom(n_i,k_i). $
先 `lucas.init(p)` 预处理 `0..p-1`，再用同一 p 调 `lucas.C(n,k,p)`。预处理 O(p) 时间、空间，单问 $O(log_p n)$；负 n、负 k 或 k>n 返回 0。

`init(p,L)` 只预处理至 L。遇到更大的数位，接口改用乘积公式，单个数位耗时 $O(min(k_i,n_i-k_i))$。大 p 时先估数位与询问总成本。

合数模改质数幂组合数加 CRT。题目：P3807。

#code("组合计数/组合数计算/Lucas 定理/Lucas.cpp", mode: "full")


]
