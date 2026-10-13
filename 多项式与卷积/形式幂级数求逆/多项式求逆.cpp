#pragma once

#include "../多项式基础运算与 NTT 接口/多项式基础.cpp"

namespace poly998 {
Poly inverse(const Poly& f, int n) {
    if(n == 0) return {};
    Poly g(1, power(f[0], MOD - 2));
    while(g.size() < n) {
        int m = g.size();
        m = min(n, m * 2);
        Poly fg = multiply(prefix(f, m), g, m);
        fg.resize(m);
        for(i64& x : fg) x = norm(-x);
        fg[0] = norm(fg[0] + 2);
        g = multiply(g, fg, m);
        g.resize(m);
    }
    return g;
}
}
