#pragma once

#include "多项式求逆.cpp"

namespace poly998 {
Poly logarithm(const Poly& f, int n) {
    if(n == 0) return {};
    assert(!f.empty() && norm(f[0]) == 1);
    Poly result = integral(multiply(derivative(f), inverse(f, n), n - 1));
    result.resize(n);
    return result;
}

Poly exponential(const Poly& f, int n) {
    if(n == 0) return {};
    assert(f.empty() || norm(f[0]) == 0);
    Poly g(1, 1);
    while((int) g.size() < n) {
        int m = min(n, (int) g.size() * 2);
        Poly correction = subtract(prefix(f, m), logarithm(g, m), m);
        correction[0] = norm(correction[0] + 1);
        g = multiply(g, correction, m);
        g.resize(m);
    }
    return g;
}
}
