#import "全根距离和：换根只改变两侧/index.typ" as section-0
#import "一般换根：前后缀排除一个儿子/index.typ" as section-1

#let render(code) = [
#heading(level: 2, outlined: true)[全根统计（换根 DP）] <book-reroot>

`rerootDistanceSum(graph,mass)` 求所有点的带权距离和：
$ "ans"[u]=sum_v "mass"[v] dot "dist"(u,v). $
顶点为 `1..n`、`n>=1`，`graph` 和 `mass` 均留 0 号位。输入为连通无向树，每条边存两次；`mass[v]=1` 得普通距离和。时间、空间 $O(n)$，遍历不使用深递归。

*换根公式*　先以 1 为根，后序求子树质量 `sub[u]` 和 `ans[1]`。从父亲 `p` 移到儿子 `u`：
$ "ans"[u]="ans"[p]+("total"-2"sub"[u]) dot w(p,u). $
子树内距离减少一条边长，外部增加一条边长；前序套式得到全部答案。

边权和质量输入为 `i64`，乘积与答案为 `i128`，所有中间量须在范围内。这里的距离按唯一简单路径定义，代数上允许有符号权；最短路或重心选址的性质另有非负要求。

改其他换根 DP 时，可加贡献用总量减子树；不可逆的结合运算用儿子前后缀聚合，求出排除当前儿子的贡献。

来源：wzj52501，#link("https://github.com/wzj52501/awesome-competitive-olympiad-algorithms/blob/c3685028be8ac258074260f8d8bd825faddc4a76/Lectures/Dynamic-Programming.pdf")[《动态规划》树形 DP 专题]。

#code("树上问题/全根统计（换根 DP）/换根距离和.cpp", mode: "full")

带权距离和 $F_u=sum_x a_x d(u,x)$，总点权 $W$、儿子子树权 $S_v$、边长 $w$：
$ F_v=F_u+(W-2S_v)w. $
普通距离和取 `W=n,S[v]=sz[v]`。一般换根用儿子前后缀聚合求排除当前儿子的贡献，非交换运算保留顺序。


#section-0.render(code)

#section-1.render(code)

]
