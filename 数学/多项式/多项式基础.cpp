#pragma once

#include "../../template/start.cpp"

namespace poly998 {
using Poly = vector<i64>;
constexpr i64 MOD = 998244353;
constexpr i64 ROOT = 3;

i64 norm(i64 x) {
    x %= MOD;
    if(x < 0) x += MOD;
    return x;
}

i64 power(i64 a, i64 e) {
    i64 r = 1;
    for(a = norm(a); e; e >>= 1, a = a * a % MOD)
        if(e & 1) r = r * a % MOD;
    return r;
}

void trim(Poly& a) {
    while(!a.empty() && a.back() == 0) a.pop_back();
}

Poly prefix(const Poly& a, int n) {
    if(n <= 0) return {};
    Poly r(min(n, (int) a.size()));
    for(int i = 0; i < (int) r.size(); i++) r[i] = norm(a[i]);
    r.resize(n);
    return r;
}

void ntt(Poly& a, bool inverse) {
    int n = (int) a.size();
    assert(n > 0 && (n & (n - 1)) == 0 && n <= (1 << 23));
    for(int i = 1, j = 0; i < n; i++) {
        int bit = n >> 1;
        for(; j & bit; bit >>= 1) j ^= bit;
        j ^= bit;
        if(i < j) swap(a[i], a[j]);
    }
    for(int len = 2; len <= n; len <<= 1) {
        i64 step = power(ROOT, (MOD - 1) / len);
        if(inverse) step = power(step, MOD - 2);
        for(int l = 0; l < n; l += len) {
            i64 w = 1;
            for(int i = 0; i < len / 2; i++) {
                i64 x = a[l + i];
                i64 y = a[l + i + len / 2] * w % MOD;
                a[l + i] = norm(x + y);
                a[l + i + len / 2] = norm(x - y);
                w = w * step % MOD;
            }
        }
    }
    if(inverse) {
        i64 invn = power(n, MOD - 2);
        for(i64& x : a) x = x * invn % MOD;
    }
}

Poly multiply(const Poly& a, const Poly& b, int need = -1) {
    assert(need >= -1);
    int sizeA = (int) a.size(), sizeB = (int) b.size();
    if(need >= 0) {
        sizeA = min(sizeA, need);
        sizeB = min(sizeB, need);
    }
    if(sizeA == 0 || sizeB == 0 || need == 0) return {};
    int full = sizeA + sizeB - 1;
    int resultSize = need < 0 ? full : min(full, need);
    if(min(sizeA, sizeB) <= 32) {
        Poly result(resultSize);
        for(int i = 0; i < sizeA; i++)
            for(int j = 0; j < sizeB && i + j < resultSize; j++)
                result[i + j] = (result[i + j] + norm(a[i]) * norm(b[j])) % MOD;
        return result;
    }
    assert(full <= (1 << 23));
    int n = (int) bit_ceil((unsigned) full);
    Poly x(n), y(n);
    for(int i = 0; i < sizeA; i++) x[i] = norm(a[i]);
    for(int i = 0; i < sizeB; i++) y[i] = norm(b[i]);
    ntt(x, false);
    ntt(y, false);
    for(int i = 0; i < n; i++) x[i] = x[i] * y[i] % MOD;
    ntt(x, true);
    x.resize(resultSize);
    return x;
}

Poly derivative(const Poly& a) {
    if(a.size() <= 1) return {};
    Poly result(a.size() - 1);
    for(int i = 1; i < (int) a.size(); i++) result[i - 1] = norm(a[i]) * i % MOD;
    return result;
}

Poly integral(const Poly& a) {
    Poly inverse(a.size() + 1), result(a.size() + 1);
    if(a.empty()) return result;
    inverse[1] = 1;
    for(int i = 2; i <= (int) a.size(); i++)
        inverse[i] = MOD - MOD / i * inverse[MOD % i] % MOD;
    for(int i = 0; i < (int) a.size(); i++) result[i + 1] = norm(a[i]) * inverse[i + 1] % MOD;
    return result;
}

Poly add(const Poly& a, const Poly& b, int n = -1) {
    int size = n < 0 ? (int) max(a.size(), b.size()) : n;
    Poly result(size);
    for(int i = 0; i < size; i++) {
        i64 x = i < (int) a.size() ? a[i] : 0;
        i64 y = i < (int) b.size() ? b[i] : 0;
        result[i] = norm(x + y);
    }
    return result;
}

Poly subtract(const Poly& a, const Poly& b, int n = -1) {
    int size = n < 0 ? (int) max(a.size(), b.size()) : n;
    Poly result(size);
    for(int i = 0; i < size; i++) {
        i64 x = i < (int) a.size() ? a[i] : 0;
        i64 y = i < (int) b.size() ? b[i] : 0;
        result[i] = norm(x - y);
    }
    return result;
}
}
