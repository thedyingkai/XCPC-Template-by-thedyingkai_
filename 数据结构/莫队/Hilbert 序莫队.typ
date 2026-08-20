Hilbert 序莫队仍然用 `add/del` 维护静态闭区间，只是把 `(l,r)` 当作平面点并按 Hilbert 序排列。它通常比固定块长更稳定地保持二维局部性，但不改变莫队必须离线、端点单步移动的前提，也不能直接代替带修改莫队。

`work` 同样从空窗口 `[1,0]` 开始，并保持回调状态恰好对应当前闭区间 `[left,right]`：扩张时先移动端点再 `add`，收缩时先 `del` 再移动端点。与普通莫队相比只替换询问排序，窗口不变量和 `add/del/answer` 接口完全相同。

- 坐标使用 `1` 下标闭区间，内部转成从 `0` 开始的平面点；当前序号使用 `u64`，要求坐标小于 $2^31$。

- 普通莫队的端点移动量约为 $Q B+N^2/B$，因此块长可取 $B=N/sqrt(Q)$；$Q$ 与 $N$ 同阶时就是 $sqrt(N)$。
- 加删常数不对称时，直接对几组块长或 Hilbert 序做本地测速；带修改莫队仍按三维排序。

- 与普通莫队相同，可用洛谷 P1494、P2709 对拍移动次数与答案。
- #link("https://judge.yosupo.jp/problem/static_range_count_distinct")[Library Checker · Static Range Count Distinct]
