#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("Knuth 优化：区间最优切点夹逼")] <trick-dp-29>
*问题概述*　#text("给定区间代价 w(l,r)，定义 ")$op("dp")_(l,l)=0$#text("、")$op("dp")_(l,r)=w(l,r)+min_(l≤k<r)(op("dp")_(l,k)+op("dp")_(k+1,r))$#text("。对任意 ")$a≤b≤c≤d$#text("，已知 ")$w(b,c)≤w(a,d)$#text(" 且 ")$w(a,c)+w(b,d)≤w(a,d)+w(b,c)$#text("。求 ")$op("dp")_(1,n)$#text("，要求总复杂度 ")$O(n^2)$#text("，不允许把这两条条件省略为对所有区间 DP 都成立。")

*必要思路*　#text("对标准 ")$op("dp")_(l,r)=w(l,r)+min_k(op("dp")_(l,k)+op("dp")_(k+1,r))$#text("，在满足所需单调性与四边形不等式时，有 ")$op("opt")_(l,r-1)≤op("opt")_(l,r)≤op("opt")_(l+1,r)$#text("。只枚举该范围；不是所有区间 DP 都满足，收益符号变化尤其要重证。")

*参考*　#link("https://oi-wiki.org/dp/opt/quadrangle/")[#text("OI Wiki：四边形不等式优化")]。



]
