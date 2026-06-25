求解同余方程组：
$cases(
  x equiv r_1 \(mod m_1\),
  x equiv r_2 \(mod m_2\),
  dots,
  x equiv r_n \(mod m_n\),
)$

每次合并执行一次扩展欧几里得：$O(log max(M, m))$，合并 $n$ 次的总复杂度：$O(n log max(m_i))$。
