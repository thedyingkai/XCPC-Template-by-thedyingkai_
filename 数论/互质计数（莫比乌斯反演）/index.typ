#import "互质筛选：莫比乌斯把 gcd=1 拆开/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[互质计数（莫比乌斯反演）] <book-mobius>

卷积 $(f ast g)(n)=sum_(d mid n)f(d)g(n/d)$，常用恒等式 $1 ast mu=epsilon$、$phi ast 1="id"$。`mu(1)=1`，含平方质因子为 0，其余为不同质因子数决定的 $(-1)^r$。

*两种方向*

- 约数和 $F(n)=sum_(d mid n)f(d)$：$f(n)=sum_(d mid n)mu(d)F(n/d)$。
- 倍数和 $F(d)=sum_(d mid v,v<=N)f(v)$：$f(d)=sum_(k=1)^(floor(N/d))mu(k)F(d k)$。

*GCD 求和*　令 $f=g ast mu$：
$ sum_(i<=n,j<=m)g(gcd(i,j))=sum_(d<=min(n,m))f(d)floor(n/d)floor(m/d). $
互质计数的权为 mu，GCD 和的权为 phi，GCD 平方和则须重算卷积权。`gcd(i,j)=k` 先将两上界除 k；矩形区间再做四次前缀容斥。

分块取 `qn=n/l,qm=m/l,r=min(n/qn,m/qm)`，贡献为 `(F[r]-F[l-1])*qn*qm`，此处 F 为反演后权 f 的前缀和。乘积先扩宽。

*整段 GCD 分布*　先求全部元素都为 d 倍数的方案 `C[d]`，再降序 `E[d]=C[d]-sum(E[k*d],k>=2)`。无序选不同位置用 `C(c[d],2)`，有序且可重复位置才用 `c[d]^2`。

mu、phi 接线性筛，权前缀接整除分块；一般卷积枚举倍数 $O(N log N)$。题目：P2522、P3455。


#section-0.render(code)

]
