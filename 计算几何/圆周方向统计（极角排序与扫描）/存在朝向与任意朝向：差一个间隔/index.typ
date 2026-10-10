#import "/template/frame.typ": extract-code
#import "/template/trick-code.typ": trick-code
#import "/计算几何/读题信号与区域赛样本/sources.typ": geom-sources, geom-source

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[存在朝向与任意朝向：差一个间隔] <geom-coverage-width>
设 $n$ 个非零方向的角度排为 $a_0<=dots<=a_(n-1)$，保留重复方向，复制 $a_(i+n)=a_i+2pi$。对 $1<=k<=n$，闭角区间的两种最小宽度为：

$ alpha_"some"=min_i (a_(i+k-1)-a_i), quad
  alpha_"every"=max_i (a_(i+k)-a_i). $

*存在一个朝向。* 取连续的 $k$ 个点，把边界放在第一个与第 $k$ 个方向即可，跨 $k-1$ 个间隔。反过来，任何含 $k$ 点的角区间都至少覆盖一组连续 $k$ 点的跨度，故取最小值。

*任意朝向。* 最坏的左边界刚越过某个 $a_i$，前面的点已经不计入，需要继续到 $a_(i+k)$ 才取得后面 $k$ 个点。若宽度小于这个间隔，选择足够接近且位于 $a_i$ 后的边界便能反证；取所有间隔的最大值则对所有边界都够用。边界恰好在点上时闭区间只会多收点。

#trick-code(extract-code(
  read("最小覆盖角宽.cpp"),
  parts: "coverage-width",
  path: "计算几何/圆周方向统计（极角排序与扫描）/存在朝向与任意朝向：差一个间隔/最小覆盖角宽.cpp",
))

$n=k=1$ 时两个答案分别是 $0$ 与 $2pi$；$n$ 个均匀方向时分别为 $(k-1)2pi/n$ 与 $k 2pi/n$。同方向的不同点必须保留，因为题目统计点数；$k=n$ 时任意朝向必须覆盖全圆，答案为 $2pi$。

2024 昆明 H 问第二种，并明确按弧度输出。该题允许多个点同向，禁止原点输入。#geom-source("kunming24")。

若换成开角区间，“存在朝向”的零宽或恰好贴端点最优值可能只是下确界，并不真正取到；“每个朝向”在临界宽度也可能差端点。上述函数专用于闭角区间，不要通过加减一个固定 eps 偷换定义。



]
