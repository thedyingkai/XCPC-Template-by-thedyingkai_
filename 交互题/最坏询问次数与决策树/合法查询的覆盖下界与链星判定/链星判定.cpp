#pragma once
#include <bits/stdc++.h>
namespace interactive {

// 保证隐藏树为链或星，n >= 4；edge(u,v) 使用 0-based 编号。
// 返回 true 表示星；至多 ceil(n/2)+3 问。
template<class Edge>
bool is_star(int n, Edge edge) {
    if (n < 4) throw std::invalid_argument("n must be >= 4");
    auto resolve = [&](int u, int v) {
        int a = -1, b = -1;
        for (int i = 0; i < n; ++i)
            if (i != u && i != v) {
                if (a == -1) a = i;
                else { b = i; break; }
            }
        bool ua = edge(u, a), va = edge(v, a);
        if (!ua && !va) return false;
        return bool(edge(ua ? u : v, b));
    };
    for (int i = 0; i + 1 < n; i += 2)
        if (edge(i, i + 1)) return resolve(i, i + 1);
    if (n % 2 && edge(n - 1, 0)) return resolve(n - 1, 0);
    return false;
}

} // namespace interactive
