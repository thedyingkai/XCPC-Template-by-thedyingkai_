#pragma once

#include "多项式对数与指数.cpp"

namespace poly998 {
Poly polynomialPowerPrepared(const Poly& f, bool zeroExponent, i64 shiftExponent,
                             i64 coefficientExponent, i64 constantExponent, int n) {
    assert(n >= 0);
    if(n == 0) return {};
    if(zeroExponent) {
        Poly answer(n);
        answer[0] = 1;
        return answer;
    }
    int first = 0;
    while(first < (int) f.size() && norm(f[first]) == 0) first++;
    if(first == (int) f.size()) return Poly(n);
    if(first && shiftExponent > (n - 1) / first) return Poly(n);
    i64 shiftValue = first * shiftExponent;
    int shift = (int) shiftValue;
    int need = n - shift;
    i64 constant = norm(f[first]);
    i64 inverseConstant = power(constant, MOD - 2);
    Poly normalized(need);
    for(int i = 0; i < need && first + i < (int) f.size(); i++)
        normalized[i] = norm(f[first + i]) * inverseConstant % MOD;
    Poly logarithmValue = logarithm(normalized, need);
    for(i64& value : logarithmValue) value = value * coefficientExponent % MOD;
    Poly result = exponential(logarithmValue, need);
    i64 scale = power(constant, constantExponent);
    Poly answer(n);
    for(int i = 0; i < need; i++) answer[i + shift] = result[i] * scale % MOD;
    return answer;
}

Poly polynomialPower(const Poly& f, i64 exponent, int n) {
    assert(exponent >= 0);
    return polynomialPowerPrepared(
        f, exponent == 0, exponent, exponent % MOD, exponent % (MOD - 1), n
    );
}

Poly polynomialPower(const Poly& f, const string& exponent, int n) {
    assert(!exponent.empty());
    bool zero = true;
    i64 capped = 0, moduloP = 0, moduloPhi = 0;
    for(char ch : exponent) {
        assert('0' <= ch && ch <= '9');
        int digit = ch - '0';
        zero &= digit == 0;
        capped = min<i64>(max(0, n), capped * 10 + digit);
        moduloP = (moduloP * 10 + digit) % MOD;
        moduloPhi = (moduloPhi * 10 + digit) % (MOD - 1);
    }
    return polynomialPowerPrepared(f, zero, capped, moduloP, moduloPhi, n);
}
}
