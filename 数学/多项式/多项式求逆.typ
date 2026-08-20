`poly998::inverse(f,n)` 求唯一的 $g$，使 $f(x)g(x) equiv 1 \(mod x^n\)$，要求 `n>=0` 且常数项非零，返回恰好 $n$ 项。Newton 迭代使用 $g'=g(2-f g)$；若旧答案在模 $x^m$ 下正确，误差会平方，因此每轮把正确长度翻倍，复杂度 $O(n log n)$。

输入不足 $n$ 项时高次项视为零。常数项为零的多项式没有形式幂级数逆元；若题目允许 Laurent 级数，应先提出最低次的 $x^k$ 并单独处理下标，不能直接调用本接口。

#link("https://judge.yosupo.jp/problem/inv_of_formal_power_series")[Library Checker · inv_of_formal_power_series]
