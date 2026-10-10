#let render(code) = [
#heading(level: 2, outlined: true)[离散对数（扩展 BSGS）] <book-exbsgs>

`exbsgs(a,b,p)` 求最小非负 x，使 `a^x≡b (mod p)`；p>0，a 可不与 p 互质，负输入会归一化，无解返回 −1。时间、空间 $O(sqrt p)$，先检查表规模是否可承受。

*约因子*　维护已取指数 k 和方程 `A*a^t≡b (mod p)`，原答案 k+t，初始 A=1。先保留 t=0 的解；若 `d=gcd(a,p)>1`，b 不被 d 整除则无解，否则 `b/=d,p/=d,A=A*(a/d)%p,k++`，再检查 `A==b`。余模与 a 互质后进 BSGS。

*最小解顺序*　取 `m=ceil(sqrt(p))`，表存 `b*a^j`，`0<=j<m`，同值保留最大 j；巨步 `A*(a^m)^i` 按 i 从 1 递增。命中得 `i*m-j+k`，每轮覆盖连续且递增的正指数段。

最小正解需另处理 x=0，互质且 b=1 时可求乘法阶。带系数 `c*a^x≡b` 先约 `gcd(c,p)`，检查整除，再逆掉余模下的 `c/d`。同模多问复用表需重新安排搜索顺序。

题目：#link("https://judge.yosupo.jp/problem/discrete_logarithm_mod")[Discrete Logarithm Mod]。

#code("数论/离散对数（扩展 BSGS）/EXBSGS.cpp", mode: "full")


]
