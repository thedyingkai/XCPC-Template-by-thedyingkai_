#let render(code) = [
#heading(level: 3, outlined: true)[高阶类欧（精确值）] <book-variant-159>

`highFloorSums(n,m,a,b)` 对 `q[i]=floor((a*i+b)/m)` 返回三个精确 `i128`：`sumFloor` 为 $F=sum q_i$，`sumIndexFloor` 为 $G=sum i q_i$，`sumFloorSquare` 为 $H=sum q_i^2$。范围 `i=0..n-1`，`n>=0,m>0`，a、b 可负。

*拆整数部分*　令 `a=qa*m+a'`、`b=qb*m+b'`，余数在 `[0,m)`；负数用数学下取整。设余数问题答案 `F',G',H'`，`S1=n(n-1)/2`、`S2=n(n-1)(2n-1)/6`：
$ F=F'+q_a S_1+q_b n, quad G=G'+q_a S_2+q_b S_1, $
$ H=H'+q_a^2 S_2+2q_a q_b S_1+q_b^2 n+2q_a G'+2q_b F'. $

*互换递推*　规范化后 `n=0` 或 `a=0` 的剩余贡献为 0。否则 `N=n-1,y=floor((a*N+b)/m)`，递归 `highFloorNonnegative(y,a,m,m-b-1)`，记返回 `f,g,h`：
$ F=N y-f, quad G=(y N(N+1)-f-h)/2, quad H=N y^2-2g-f. $
递归深度与欧几里得算法同阶。

*区间与余数*　区间 `L..R` 用前缀相减；若平移 `b+=a*L,n=R-L+1`，带下标和另加 `L*F`。非负余数 `r[i]=a*i+b-m*q[i]` 满足
$ sum r_i=a S_1+n b-m F, $
$ sum r_i^2=a^2S_2+2a b S_1+n b^2-2m(a G+b F)+m^2H. $
所有参数乘积、中间式都须装入 `i128`；只要模值且精确量过大时，用下一份模递推。

#code("数论/线性取整求和（类欧几里得）/高阶类欧（精确值）/高阶类欧.cpp", mode: "full")


]
