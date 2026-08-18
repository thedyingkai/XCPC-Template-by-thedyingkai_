#pragma once

#include "多项式基础.cpp"

namespace poly998 {
Poly inverse(const Poly& f, int n) {
    assert(n >= 0);
    if(n == 0) return {};
    assert(!f.empty() && norm(f[0]) != 0);
    Poly g(1, power(f[0], MOD - 2));
    while((int) g.size() < n) {
        int m = min(n, (int) g.size() * 2);
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
