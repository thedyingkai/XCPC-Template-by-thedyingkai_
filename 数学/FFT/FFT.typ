`FFT::multiply(a,b)` 用复数 FFT 求整数系数卷积，输入和输出均为 `1` 下标，结果有效区间为 `1..l1+l2-1`。变换后实部经四舍五入存入 `int`，所以它适合系数和长度使真实卷积系数仍在 `int` 内、且浮点误差可控的场合；系数更大时应改返回类型并评估误差，必要时拆系数或改用 NTT/CRT。

十进制大整数乘法可把最低位放在下标一，卷积后调用 `get(ans,10)` 进位。`get` 只处理非负系数，并用单个字符输出一位，因此 `base` 只能直接取不超过十的数；带符号输入先拆符号。相关匹配则翻转一个序列后卷积，把下标差转成下标和。

#link("https://judge.yosupo.jp/problem/multiplication_of_big_integers")[Library Checker · multiplication_of_big_integers]
