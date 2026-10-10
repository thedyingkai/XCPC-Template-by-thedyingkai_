#let render(code) = [
#heading(level: 2, outlined: true)[字典序因子分解与最小循环表示（Lyndon）] <book-lyndon>

Duval 在线性时间将串分解成字典序不增的 Lyndon 因子。Lyndon 串严格小于每个非空真后缀，且无非空真 border。

- `factorize` 返回 0 下标半开区间，相同的相邻因子分别输出；如 `abab` 分成 `ab | ab`。
- `min_rotation` 返回最小循环表示的最小起点，空串返回 0；答案为 `s.substr(pos)+s.substr(0,pos)`。

时间 $O(n)$，因子输出占 $O(n)$ 空间。扫描的 `i` 为当前起点，`j` 向右，`k` 跟踪重复位置：相等则推进 `k`，`s[k]<s[j]` 时重置 `k=i`，遇逆序或末尾时按长度 `j-k` 输出完整块。

改整数序列时保留全序比较，去掉 `unsigned char` 强转，以复制两遍元素代替字符串拼接。循环同构须先检查等长；最小表示仍只取原串长度。

题目：P1368；#link("https://judge.yosupo.jp/problem/lyndon_factorization")[Lyndon Factorization]。

#code("字符串/字典序因子分解与最小循环表示（Lyndon）/Lyndon 分解.cpp")


]
