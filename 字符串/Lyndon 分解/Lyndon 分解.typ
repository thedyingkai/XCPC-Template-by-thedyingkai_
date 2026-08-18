==== 输入与产物

- 输入一个字符串，按字典序分解成唯一的 Lyndon 串序列。
- `factorize(s)` 返回每个因子的半开区间；`min_rotation(s)` 返回字典序最小循环表示的起点。
- 适合 Lyndon 分解和最小表示法，同样可处理有全序的整数序列。

==== 接口与定义

- Lyndon 串严格小于它的每个非空真后缀。任意字符串唯一分解为字典序不增的 Lyndon 串序列。
- 半开区间使用 `0` 下标，相邻相同因子仍分别返回。
- `min_rotation` 在有多个最小表示时取最小起点；答案串为 `s.substr(pos)+s.substr(0,pos)`，空串返回 `0`。

==== 改法与 trick

- 判断循环同构只需在 `t+t` 中匹配 `s`；需要最小循环表示时再用 `min_rotation`。
- Lyndon 分解只依赖元素全序。改整数序列时还要去掉代码中的 `unsigned char` 强转，并用插入两遍元素代替字符串的 `source+source`；无需离散化。

==== 板子题

- Library Checker「Lyndon Factorization」；洛谷 P1368「工艺」。
