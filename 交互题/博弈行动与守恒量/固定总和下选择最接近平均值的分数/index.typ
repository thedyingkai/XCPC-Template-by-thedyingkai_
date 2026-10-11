#let render(code) = [
#heading(level: 3, outlined: true)[固定总和下选择最接近平均值的分数] <inter-middle-race>

绵阳 Middle Race 每轮三人分配 A、B、C，共 n 轮，自己希望总分居中。所有人的可行总分属于
$ cal(F)={A x+B y+C z:x+y+z=n, x,y,z>=0}. $
三人总和恒为 $n(A+B+C)=3mu$。选其中离 mu 最近的自己总分 X，按对应次数拿数。

若自己严格最大，$X>mu$。最接近平均值的性质使其他低于 X 的可行分数不能在 $(2mu-X,X)$ 内，故 $Y,Z<=2mu-X$。则 $X+Y+Z<=4mu-X<3mu$，矛盾。严格最小同理。目标对对手所有合法分配成立，不必由回包改变策略。

计算可比较整数 $|3X-n(A+B+C)|$，不引入浮点平均值。朴素枚举 x,y、令 z=n-x-y 为 $O(n^2)$，是否需要优化按原题范围决定。每轮仍读齐对手选择。#link("https://codeforces.com/gym/104065/problem/J")[原题]。
]
