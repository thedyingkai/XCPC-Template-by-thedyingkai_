#let render(code) = [
#heading(level: 2, outlined: true)[排序与逆序对（归并排序）] <book-merge-sort>

稳定排序并统计严格逆序对，时间 $O(n log n)$，空间 $O(n)$。构造 `MergeSorter(n)`，填 `a[1..n]`，调用 `sort(n)`；原地排序后的结果在 `a`，逆序对在 `inv_count`，每次排序会重置计数。

`sort(n,compare)` 接受严格弱序；等价元素保留原顺序。逆序对相对该比较序定义：右侧元素严格先于左侧当前元素时，增加左侧剩余数量。

元素固定为 `int`，计数为 `i64`；扩大值域时同时改 `a`、`temp`。排序对象可存编号，比较器通过编号访问原对象。

极角排序按 `y<0`、`y==0 && x>=0`、其余三组依次排列，组内用 `cross(left,right)>0`，叉积先扩到 `i128`。

题目：P1908；#link("https://judge.yosupo.jp/problem/sort_points_by_argument")[Sort Points by Argument]。

#code("工具与通用技巧/排序与逆序对（归并排序）/归并排序.cpp")


]
