#pragma once

#include "../形式幂级数对数与指数/多项式对数与指数.cpp"

namespace poly998 {
Poly polyPowCore(const Poly& f, bool zeroExponent, i64 shiftExponent,
                             i64 ke, i64 kc, int n) {
    if(n == 0) return {};
    if(zeroExponent) {
        Poly answer(n);
        answer[0] = 1;
        return answer;
    }
    int first = 0;
    while(first < f.size() && norm(f[first]) == 0) first++;
    if(first == f.size()) return Poly(n);
    if(first && shiftExponent > (n - 1) / first) return Poly(n);
    i64 shiftValue = first * shiftExponent;
    int shift = (int) shiftValue;
    int need = n - shift;
    i64 constant = norm(f[first]);
    i64 invC = power(constant, MOD - 2);
    Poly normalized(need);
    for(int i = 0; i < need && first + i < f.size(); i++)
        normalized[i] = norm(f[first + i]) * invC % MOD;
    Poly lg = logarithm(normalized, need);
    for(i64& value : lg) value = value * ke % MOD;
    Poly result = exponential(lg, need);
    i64 scale = power(constant, kc);
    Poly answer(n);
    for(int i = 0; i < need; i++) answer[i + shift] = result[i] * scale % MOD;
    return answer;
}

Poly polyPow(const Poly& f, i64 exponent, int n) {
    return polyPowCore(
        f, exponent == 0, exponent, exponent % MOD, exponent % (MOD - 1), n
    );
}

Poly polyPow(const Poly& f, const string& exponent, int n) {
    bool zero = true;
    i64 capped = 0, moduloP = 0, moduloPhi = 0;
    for(char ch : exponent) {
        int digit = ch - '0';
        zero &= digit == 0;
        capped = min<i64>(max(0, n), capped * 10 + digit);
        moduloP = (moduloP * 10 + digit) % MOD;
        moduloPhi = (moduloPhi * 10 + digit) % (MOD - 1);
    }
    return polyPowCore(f, zero, capped, moduloP, moduloPhi, n);
}
}
