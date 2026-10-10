#let render(code) = [
#heading(level: 3, outlined: true)[高阶类欧（取模）] <book-variant-160>

`highFloorSumsMod(n,m,a,b,mod)` 返回前节三项 `F,G,H` 的模值，范围 `i=0..n-1`。要求 `n>=0,m>0`，a、b 可负；mod 是正奇数，可为合数，mod=1 返回全零。

几何参数与分支用精确 `i128`，统计量全程取模。`a/m,b/m,floor((a*(n-1)+b)/m)` 决定实际整点范围，不对答案模数取余。

*除法*　递推中除以 2 用奇数模逆元 `(mod+1)/2`。下标平方和的除以 6 先从整数因子约去 2、3，再取模，因此 mod 可被 3 整除。偶数模需另保存整除信息。

同模多问可复用 `HighFloorSumsModSolver` 的 `solve`。区间平移、余数和与平方和按前节公式，在模域中逐项计算。

P5170 求 `i=0..n`，传 `n+1,c,a,b,998244353`；输出顺序为 F、H、G，与字段排列不同。

#code("数论/线性取整求和（类欧几里得）/高阶类欧（取模）/高阶类欧取模.cpp", mode: "full")

#pagebreak()


]
