#pragma once

#include "../形式幂级数求逆/多项式求逆.cpp"

namespace poly998 {
Poly logarithm(const Poly& f, int n) {
    if(n == 0) return {};
    Poly result = integral(multiply(derivative(f), inverse(f, n), n - 1));
    result.resize(n);
    return result;
}

Poly exponential(const Poly& f, int n) {
    if(n == 0) return {};
    Poly g(1, 1);
    while(g.size() < n) {
        int m = g.size();
        m = min(n, m * 2);
        Poly correction = subtract(prefix(f, m), logarithm(g, m), m);
        correction[0] = norm(correction[0] + 1);
        g = multiply(g, correction, m);
        g.resize(m);
    }
    return g;
}
}
