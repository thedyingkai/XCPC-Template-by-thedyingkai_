归并排序递归排好左右两半，再用两个指针线性合并；右半元素先于左半剩余元素取出时，它与左半所有剩余元素都构成逆序对。当前 `a[1..n]` 原地排序并把严格逆序对数写入 `inv_count`；`sort(n,compare)` 接受自定义严格弱序且保持等价元素的原顺序，可把对象编号放进数组、在比较器中访问对象本体。

- 构造 `MergeSorter(n)` 后把数据写入 `a[1..n]`，调用 `sort(n)`；`a[0]` 不参与排序。
- `sort` 每次调用前都会重置 `inv_count`；传入自定义序时，`inv_count` 统计的是初始编号序相对该比较序的逆序对。
- 元素类型固定为 `int`，逆序对答案为 `i64`；值超出 `int` 时同步修改 `a`、`temp` 的类型。

- 洛谷 P1908「逆序对」。
- Library Checker 的极角排序用点编号作为 `a[i]`。比较器先把 `y<0`、`y==0 且 x>=0`、其余点分成 `-1,0,1` 三段；段内用 `cross(left,right)>0` 判断先后，叉积用 `i128`。这部分是题目的极角顺序，真正的排序和稳定合并仍由本板完成。
- #link("https://judge.yosupo.jp/problem/sort_points_by_argument")[Library Checker · Sort Points by Argument]
