#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[atan、atan2、asin、acos 的输入与值域] <geom-angle-functions>
#table(columns: (auto, 1fr, 1fr), inset: 4pt,
  table.header([函数], [输入与返回], [何时容易误用]),
  [`atan(t)`], [已知正切值，有限实数返回 $(-pi/2,pi/2)$], [斜率丢失象限；垂直方向不能先除],
  [`atan2(y,x)`], [向量 $(x,y)$ 的方向，返回 $[-pi,pi]$], [参数先 $y$ 后 $x$；负 $x$ 轴是接缝],
  [`acos(t)`], [已知余弦值，返回 $[0,pi]$], [只能求无向角；输入须在 $[-1,1]$],
  [`asin(t)`], [已知正弦值，返回 $[-pi/2,pi/2]$], [无法区分同正弦的锐角与钝角],
)

角度单位都是弧度：$180^degree=pi$，$theta_"rad"=theta_"deg" pi/180$。`atan` 是反正切，既不是正切函数，也不是 $1/tan$。库函数对无穷、正负零等另有规定；几何算法不要用这些特殊返回值代替对象存在性判断。

例如 $(1,1)$ 与 $(-1,-1)$ 的斜率同为 $1$，`atan(y/x)` 都给 $pi/4$，但实际方向相反；$(-1,1)$ 的斜率是 $-1$，`atan` 给 $-pi/4$，实际极角是 $3pi/4$。$(0,1)$ 朝上，正确调用是 `atan2l(1,0)`；交换参数会得到朝右的角 $0$。

`i64 x=2,y=1;` 后调用 `atan(y/x)`，整数除法先把比值变成 $0$。`d128 a=atan2(y,x)` 也不会自动恢复高精度：整数实参按 C++ 的重载规则在此按 `double` 处理。用 `atan2l((d128)y,(d128)x)` 或明确传入长双精度。接收变量的类型无法挽回此前的整数溢出与浮点舍入。

函数接口和重载规则可查 #link("https://eel.is/c++draft/cmath.syn")[C++ 标准草案的 cmath 说明]。



]
