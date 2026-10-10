#import "筛质数/index.typ" as section-0
#import "筛积性函数/index.typ" as section-1

#let render(code) = [
#heading(level: 2, outlined: true)[质数与积性函数预处理（线性筛）] <book-linear-sieve>

`Prime pr; pr.sieve(n);` 求不超过 n 的质数，要求 `n>=1`；结果在 `pr.primes`，`pr.is_prime` 只查 `1..n`，0 号未清零。`Sieve sv; sv.init(n);` 另求 phi、mu、约数个数 d、约数和 sigma，允许 `n=0`。两板数组均含 n，时间、空间 $O(n)$。

每个合数由最小质因子唯一生成：枚举质数 p 时，`i%p==0` 后必须 break。积性函数区分“原有质因子次数加一”和“新增互质因子”两种递推。

需最小质因子时，质数处记 `minp[i]=i`，生成 `i*p` 时记 `minp[i*p]=p`。前缀和另开数组，保留单点函数值。

sigma 为精确 `i64`；扩范围或取模时同步处理 `p_power,p_sum`。范围大到无法开 O(n) 数组时，只筛至平方根作基质数，再分段标记原区间。


#section-0.render(code)

#section-1.render(code)

]
