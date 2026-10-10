#import "Knuth 优化：区间最优切点夹逼/index.typ" as section-0

#let render(code) = [
#heading(level: 2, outlined: true)[区间切点优化（Knuth）] <book-knuth>

合并一条线上相邻石子，单次代价为被合并区间总重量，求最小总成本。输入 `a` 为 0 下标且全部非负；`KnuthMerge(a).answer()` 返回 `i128`，空数组、单元素均为 0。

*转移与范围*
$ "dp"[l][r]=min_(l<=k<r)("dp"[l][k]+"dp"[k+1][r])+C(l,r). $
初始化 `dp[i][i]=0, opt[i][i]=i`；按长度递增，只枚举
$ "opt"[l][r-1]<=k<=min(r-1,"opt"[l+1][r]). $
同值用 `<=` 更新，统一取最右最优决策。`opt` 可递归恢复合并树。

*套到其他代价前检查*　对 $a<=b<=c<=d$，要求
$ C(a,c)+C(b,d)<=C(a,d)+C(b,c), quad C(b,c)<=C(a,d). $
非负区间和满足这两式。负权、额外罚值、最大化版本须重新验证条件。

时间、空间均 $O(n^2)$。`i128 dp` 与 `int opt` 主体约占 `20*n*n` 字节，`n=3000` 时约 180 MB，另有行容器开销。

*环形*　复制数组，计算长度不超过原长 `n` 的区间，答案取 `min(dp[l][l+n-1])`，`0<=l<n`。

来源：wzj52501，#link("https://github.com/wzj52501/awesome-competitive-olympiad-algorithms/blob/c3685028be8ac258074260f8d8bd825faddc4a76/Lectures/Dynamic-Programming-Talk.pdf")[《浅谈动态规划》16–22 页]。

#code("动态规划/区间切点优化（Knuth）/Knuth 石子合并.cpp")


#section-0.render(code)

]
