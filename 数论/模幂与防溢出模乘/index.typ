#import "普通快速幂/index.typ" as section-0
#import "快速乘/index.typ" as section-1
#import "龟速乘/index.typ" as section-2

#let render(code) = [
#heading(level: 2, outlined: true)[模幂与防溢出模乘] <book-mod-power>

`qp(a,k,p)` 求 $a^k mod p$，要求 `p>0,k>=0`，乘法用 `i128`。时间 $O(log k)$，常数额外空间；`k=0` 返回模意义单位元。负指数须先求逆元，再取非负幂。

`Matrix<T>::qp(A,k)` 用于固定线性转移，A 必须为方阵。d 阶朴素矩阵幂时间 $O(d^3 log k)$，空间 $O(d^2)$。该短板不自动取模，元素和中间乘加须在类型范围内；模递推题使用模数类型或补取模。

初始列向量 v、一步矩阵 A，第 k 步为 `A^k*v`。仿射转移增加一个恒为 1 的坐标。矩阵乘法保留顺序，不能按标量乘法交换。

题目：#link("https://judge.yosupo.jp/problem/pow_of_matrix")[Pow of Matrix]。


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

]
