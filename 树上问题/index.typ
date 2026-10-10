#import "子树区间与祖先判断（DFS 序）/index.typ" as section-0
#import "最近公共祖先（LCA）/index.typ" as section-1
#import "路径与子树查询（树链剖分）/index.typ" as section-2
#import "树上路径离线统计（欧拉序莫队）/index.typ" as section-3
#import "批量路径更新（树上差分）/index.typ" as section-4
#import "全根统计（换根 DP）/index.typ" as section-5
#import "全点对距离与分支贡献/index.typ" as section-6
#import "树上距离约束统计（点分治）/index.typ" as section-7
#import "最远点与点集直径/index.typ" as section-8
#import "少量关键点构树（虚树）/index.typ" as section-9
#import "树上连通块计数（树形 DP）/index.typ" as section-10
#import "树上背包与依赖选择/index.typ" as section-11
#import "子树集合统计（启发式合并）/index.typ" as section-12
#import "树同构判定/index.typ" as section-13
#import "动态森林路径查询（Link-Cut Tree）/index.typ" as section-14
#import "动态森林连通块统计（Euler Tour Tree）/index.typ" as section-15
#import "单边改权维护直径（静态拓扑 Top Tree）/index.typ" as section-16
#import "树的编码与计数（Prüfer 序列）/index.typ" as section-17

#let render(code) = [
#heading(level: 1, outlined: true)[树上问题] <chapter-tree>

#text("树默认无向连通无环。距离与直径性质默认非负边权；按边贡献求距离和仍允许负边权。深树遍历注意调用栈。")

#text("每条先给明确问题模型，再给必要思路与适用条件。参考链接用于追溯知识，应用情景由本文重新整理。")

以下静态树公式按固定根预处理 `parent/dep/dfn/sz/LCA`，区间均闭合。路径修改最后统一结算用差分；在线操作接树链剖分。

题目：P3128、P2680、P3478。


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

]
