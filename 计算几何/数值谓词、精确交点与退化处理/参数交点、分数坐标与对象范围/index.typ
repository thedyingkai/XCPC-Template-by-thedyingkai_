#import "/template/frame.typ": extract-code
#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[参数交点、分数坐标与对象范围] <geom-exact-intersection>
两条参数直线为 $A+t u$ 与 $C+s v$，其中方向非零。若 $D=u times v!=0$，有

$ t=((C-A) times v)/D, quad
  s=((C-A) times u)/D. $

随后交点为 $A+t u$。无限直线的参数无约束；射线要求 $t>=0$，线段要求 $0<=t<=1$，第二个对象的 $s$ 也要按自身类型检查。

若 $D=0$，先判平行不重合还是共线重合；线段在共线时可能不交、单点接触或整段重叠，不能只返回一个交点。方向为零时对象退化为点，再走点与对象的分支。基础 `lineIntersection` 只处理非平行无限直线，不等于线段相交判定。

整数输入下可保留参数分子分母；先把分母统一为正，线段参数合法性直接比较 $0<=N<=D$，无需除法，也不用交叉相乘。需要分数坐标时，横坐标分子为 $A_x D+u_x N$，纵坐标同理，再分别约分。

#trick-code(extract-code(
  read("精确直线交点.cpp"),
  parts: "exact-intersection",
  path: "计算几何/数值谓词、精确交点与退化处理/参数交点、分数坐标与对象范围/精确直线交点.cpp",
))

返回 `nullopt` 只说明平行或重合，调用者按 `orient128(A,B,C)` 继续区分；该接口不返回重叠区间。分数分子含三次乘积，坐标绝对值在 $10^9$ 级时容易放进 `i128`，全范围 `i64` 不满足这个保证。最小有符号整数的取负也会溢出，范围证明须覆盖规范化步骤。

只判两线段是否相交时，使用端点方向符号与包围盒即可；严格相交要求两组朝向分别异号，边界接触另判。先用精确谓词分类，再在题目确实要交点时调用构造函数。



]
