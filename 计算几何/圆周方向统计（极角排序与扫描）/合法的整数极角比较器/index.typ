#import "/template/frame.typ": extract-code
#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[合法的整数极角比较器] <geom-polar-order>
整数点且答案依赖精确的顺序、同向、反向时，用半平面分类加 `i128` 叉积。需要实际角度长度且题目允许误差时，先用 `atan2l` 求值再排序更直接。先问算法需要哪一种信息。

下面从正 $x$ 轴开始逆时针排序。`polarHalf=0` 表示 $[0,pi)$，`polarHalf=1` 表示 $[pi,2pi)$；同一半平面内两方向的角差小于 $pi$，叉积才能给出一致的先后关系。

#trick-code(extract-code(
  read("整数极角.cpp"),
  parts: "integer-polar",
  path: "计算几何/圆周方向统计（极角排序与扫描）/合法的整数极角比较器/整数极角.cpp",
))

比较器只用于非零向量。同向向量等价，`std::sort` 可以任意排列它们；若要同向按距离排，再在叉积为零时比较长度平方，或按原编号确定稳定次序。需要保留编号时可排序下标，不要去重后丢掉权重与原位置。

从中心 $O$ 转成向量 $p-O$ 时，板子的 `Point<i64>` 减法仍在 `i64` 中执行。差值必须装入该类型；`orient128` 则在减法前提升，适合直接判三个整数点的朝向。两者的前提不能混淆。



]
