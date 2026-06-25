- 时间复杂度：插入/查询 $O(log C)$，$C$ 为值域（如 $2^60$）。第 $k$ 小需要预处理 $O((log C)^2)$。
- 空间复杂度：$O(log C)$。

#align(center)[
  #table(
    columns: (auto, auto),
    align: center,
    table.header(
      [*方法*],
      [*功能*],
    ),
    [`insert(x)`],
    [将 $x$ 插入线性基],
    [`can(x)`],
    [判断能否通过原数集的异或得到 $x$],
    [`max_xor()`],
    [原数集能异或出的最大值],
    [`min_xor()`],
    [原数集能异或出的最小值（含 $0$）],
    [`kth(k)`],
    [第 $k$ 小的异或值（$k >= 1$，包含 $0$）],
  )
]