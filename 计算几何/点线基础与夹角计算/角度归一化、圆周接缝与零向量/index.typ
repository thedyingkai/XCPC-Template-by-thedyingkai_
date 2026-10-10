#import "/template/frame.typ": extract-code
#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[角度归一化、圆周接缝与零向量] <geom-angle-normalize>
方向 $179^degree$ 与 $-179^degree$ 的最短差为 $2^degree$，直接相减的绝对值却是 $358^degree$。圆周被映射到线性区间后总有一道接缝；归一化只能统一表示，环形算法还须保留绕圈次数。

射线方向模 $2pi$，无向直线方向模 $pi$。下面的函数处理负余数、加法舍入落到周期端点，以及正负零：

#trick-code(extract-code(
  read("角度计算.cpp"),
  parts: "angle",
  path: "计算几何/点线基础与夹角计算/角度归一化、圆周接缝与零向量/角度计算.cpp",
))

`normAngle(atan2l(y,x))` 得到第一圈方向；复制第二圈必须写 `a[i+n]=a[i]+2*GEOM_PI`，不能再次归一化。后者会把转了 $2pi$ 与没转区分不出来。

几何上 $(0,0)$ 没有方向，但一些实现的 `atan2l(0,0)` 仍返回 $0$。负 $x$ 轴上，正负零的 $y$ 还可能分别产生 $pi$ 与 $-pi$。因此不要用“函数有没有返回 NaN”检测零向量，也不要用原始角度完全相等判断整数射线相同。



]
