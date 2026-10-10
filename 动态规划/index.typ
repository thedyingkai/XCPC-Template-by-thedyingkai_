#import "背包选择/index.typ" as section-0
#import "布尔可达性与方案恢复（bitset 背包）/index.typ" as section-1
#import "序列最优值与前驱重建（LIS）/index.typ" as section-2
#import "偏序约束下的最优序列/index.typ" as section-3
#import "状态等价、守恒与支配关系/index.typ" as section-4
#import "未来成本的提前结算/index.typ" as section-5
#import "区间求和转移（前缀和）/index.typ" as section-6
#import "滑动窗口最优转移（单调队列）/index.typ" as section-7
#import "绝对值与两侧代价转移/index.typ" as section-8
#import "区间合并与消除/index.typ" as section-9
#import "区间切点优化（Knuth）/index.typ" as section-10
#import "同步多路径状态/index.typ" as section-11
#import "集合分组与子集状态/index.typ" as section-12
#import "窄网格边界状态（轮廓 DP）/index.typ" as section-13
#import "数字范围计数（数位 DP）/index.typ" as section-14
#import "最优值与方案数共同维护/index.typ" as section-15
#import "直线型转移（斜率优化）/index.typ" as section-16
#import "决策单调的分治优化/index.typ" as section-17
#import "恰好 K 次选择（WQS 二分）/index.typ" as section-18
#import "凸分段线性代价（Slope Trick）/index.typ" as section-19
#import "按值插入的连续段状态/index.typ" as section-20
#import "有限状态的巨大步数转移（矩阵加速）/index.typ" as section-21
#import "有向无环状态图（DAG DP）/index.typ" as section-22

#let render(code) = [
#heading(level: 1, outlined: true)[动态规划] <chapter-dp>

建状态时写清“已处理什么、还需记住什么、值表示什么”，再按依赖顺序转移。朴素时间为状态数乘转移枚举量；空间优化先检查旧层数据何时还能被读取。

#table(
 columns: (auto, 1fr, 1fr),
 table.header([模型], [状态与答案], [顺序与边界]),
 [背包], [容量至多或恰好；最大价值], [01 倒序，完全正序；恰好模式仅 `dp[0]` 可达],
 [序列], [前缀最优或以某项结尾], [LIS 严格用 `lower_bound`，不下降用 `upper_bound`],
 [区间], [`dp[l][r]` 处理整个区间], [长度递增；通常枚举最后分割点],
 [树形], [子树及对父连接状态], [后序聚合，前序换根；深树用显式遍历序],
 [状压], [`dp[S][v]` 访问集合后停在 `v`], [起点、终点与是否回起点决定初值和答案],
 [数位], [位置、上界、前导零、题目属性], [缓存无上界限制的状态；其余影响后续的属性都入状态],
)

*初始化*　最小值不可达设正无穷，最大值设负无穷，转移前判可达。滚动数组保留依赖层；树上背包合并时分清旧子树状态与本轮新状态。大累计量用 `i128`，输出接杂项中的重载。

*优化入口*　滑动窗口最值用单调队列，一次函数决策用李超树，偏序转移用 CDQ。Knuth 针对区间分割，检查四边形不等式与包含单调性；分治决策优化检查同一层最优决策单调性，按各自状态和边界实现。

Hamilton 路径的 `dp[S][v]` 只从集合内末端走到集合外顶点，时间 $O(n^2 2^n)$。先跑最短路再状压用于走访关键点；若限制每点只访问一次，中途经过其他关键点会改变合法性。数位题另定整数 0 是否计入答案。

来源：wzj52501，#link("https://github.com/wzj52501/awesome-competitive-olympiad-algorithms/blob/c3685028be8ac258074260f8d8bd825faddc4a76/Lectures/Dynamic-Programming.pdf")[《动态规划》]及《浅谈动态规划》。本章说明文字采用 #link("https://creativecommons.org/licenses/by-nc-sa/4.0/")[CC BY-NC-SA 4.0]，C++ 实现采用本项目 MIT 许可。

#text("状态、转移和初值必须对应同一计数口径。最小值不可达设正无穷，最大值设负无穷；复杂度按状态数乘转移成本估算。")

#text("每条先给明确问题模型，再给必要思路与适用条件。参考链接用于追溯知识，应用情景由本文重新整理。")


#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

#section-4.render(code)

#section-5.render(code)

#section-6.render(code)

#section-7.render(code)

#section-8.render(code)

#section-9.render(code)

#section-10.render(code)

#section-11.render(code)

#section-12.render(code)

#section-13.render(code)

#section-14.render(code)

#section-15.render(code)

#section-16.render(code)

#section-17.render(code)

#section-18.render(code)

#section-19.render(code)

#section-20.render(code)

#section-21.render(code)

#section-22.render(code)

]
