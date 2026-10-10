#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[用 atan2(cross,dot) 求四种不同的夹角] <geom-relative-angle>
叉积和点积具有相同的正比例因子 $|u||v|$，因此

$ theta=op("atan2")(u times v,u dot.op v). $

它直接利用正弦和余弦的符号恢复象限，省去两次长度与一次除法。根据题意选择：

#table(columns: (1fr, 1fr), inset: 4pt,
  table.header([目标], [公式]),
  [最短有向转角，$[-pi,pi]$], [$op("atan2")(u times v,u dot.op v)$],
  [逆时针转角，$[0,2pi)$], [对上一式归一化到一个完整周期],
  [两向量普通夹角，$[0,pi]$], [$op("atan2")(|u times v|,u dot.op v)$],
  [两条无向直线的小夹角，$[0,pi/2]$], [$op("atan2")(|u times v|,|u dot.op v|)$],
)

反向向量的普通夹角是 $pi$，对应的两条无向直线夹角却是 $0$。有向角在恰好反向时存在 $pi$ 与 $-pi$ 两种表示；需要统一顺逆时针约定时，把结果模 $2pi$，不要用它的符号给反向向量随意分类。

只算 `asin(cross/(len1*len2))` 会把钝角折回锐角，只算 `acos(dot/(len1*len2))` 会丢失顺逆时针。小角度下 $1-cos theta approx theta^2/2$，若 $theta approx 10^(-12)$，差值约 $5 times 10^(-25)$，余弦可能被舍入为 $1$；`atan2(abs(cross),dot)` 通常更适合保留小角度，但它也不能修复已经算错的叉积。



]
