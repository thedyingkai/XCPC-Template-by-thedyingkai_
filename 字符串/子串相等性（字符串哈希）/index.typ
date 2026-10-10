#let render(code) = [
#heading(level: 2, outlined: true)[子串相等性（字符串哈希）] <book-string-hash>

双模前缀哈希，预处理和空间 $O(n)$，`get(l,r)` 在 $O(1)$ 返回 0 下标半开子串 `[l,r)` 的哈希。比较相等先查长度，再比较两个模数的值；不同 `StringHash` 对象可比较，因其底数与模数一致。

*常用式*

- 拼接：`H(A+B)=H(A)*BASE^len(B)+H(B)`，两个模数分别计算。
- 回文：原串 `[l,r)` 对应反串 `[n-r,n-l)`。
- LCP：二分相等前缀长度，再由下一字符判断字典序。
- 整串去重：键同时保存长度与双哈希。

存在碰撞概率。随机底数在进程启动时选一次，所有对象共用；需要确定性时用 SA、KMP 等。整数字符先统一离散化并加一，保留同一套编码。

题目：P3370；#link("https://judge.yosupo.jp/problem/longest_common_substring")[Longest Common Substring]。

#code("字符串/子串相等性（字符串哈希）/字符串哈希.cpp")


]
