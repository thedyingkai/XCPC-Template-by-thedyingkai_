#pragma once

#include "多项式求逆.cpp"

namespace poly998 {
i64 modularSquareRoot(i64 a) {
    a = norm(a);
    if(a == 0) return 0;
    if(power(a, (MOD - 1) / 2) != 1) return -1;
    if(MOD % 4 == 3) return power(a, (MOD + 1) / 4);
    i64 q = MOD - 1, z = 2;
    int s = 0;
    while(!(q & 1)) q >>= 1, s++;
    while(power(z, (MOD - 1) / 2) != MOD - 1) z++;
    i64 c = power(z, q), x = power(a, (q + 1) / 2), t = power(a, q);
    int m = s;
    while(t != 1) {
        int i = 1;
        i64 value = t * t % MOD;
        while(i < m && value != 1) value = value * value % MOD, i++;
        if(i == m) return -1;
        i64 b = power(c, 1LL << (m - i - 1));
        x = x * b % MOD;
        t = t * b % MOD * b % MOD;
        c = b * b % MOD;
        m = i;
    }
    return min(x, MOD - x);
}

optional<Poly> squareRoot(const Poly& f, int n) {
    if(n == 0) return Poly{};
    int first = 0;
    while(first < n && (first >= (int) f.size() || norm(f[first]) == 0)) first++;
    if(first == n) return Poly(n);
    if(first & 1) return nullopt;
    int shift = first / 2, need = n - first;
    Poly reduced(need);
    for(int i = 0; i < need && first + i < (int) f.size(); i++)
        reduced[i] = norm(f[first + i]);
    i64 root = modularSquareRoot(reduced[0]);
    if(root == -1) return nullopt;
    Poly g(1, root);
    const i64 inv2 = (MOD + 1) / 2;
    while((int) g.size() < need) {
        int m = min(need, (int) g.size() * 2);
        Poly quotient = multiply(prefix(reduced, m), inverse(g, m), m);
        g.resize(m);
        for(int i = 0; i < m; i++) g[i] = (g[i] + quotient[i]) * inv2 % MOD;
    }
    Poly answer(n);
    for(int i = 0; i < need && i + shift < n; i++) answer[i + shift] = g[i];
    return answer;
}
}
