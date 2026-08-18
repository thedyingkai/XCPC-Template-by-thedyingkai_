#include "../../template/start.cpp"

i64 lagrangePower(i64 a, i64 e, i64 mod) {
    i64 res = 1 % mod;
    a %= mod;
    if(a < 0) a += mod;
    while(e > 0) {
        if(e & 1) res = (i128) res * a % mod;
        a = (i128) a * a % mod;
        e >>= 1;
    }
    return res;
}

// y[i] = P(i), i = 0..k. Returns P(x) modulo prime_mod in O(k).
i64 lagrangeConsecutive(const vector<i64>& y, i64 x, i64 prime_mod) {
    int k = (int) y.size() - 1;
    if(k < 0) return 0;
    assert(prime_mod > 1 && (i64) k < prime_mod);
    i64 xm = x % prime_mod;
    if(xm < 0) xm += prime_mod;
    if(xm <= k) return (y[xm] % prime_mod + prime_mod) % prime_mod;

    vector<i64> fac(k + 1, 1), ifac(k + 1, 1);
    for(int i = 1; i <= k; i++) fac[i] = (i128) fac[i - 1] * i % prime_mod;
    ifac[k] = lagrangePower(fac[k], prime_mod - 2, prime_mod);
    for(int i = k; i >= 1; i--) ifac[i - 1] = (i128) ifac[i] * i % prime_mod;

    vector<i64> pre(k + 2, 1), suf(k + 2, 1);
    for(int i = 0; i <= k; i++) {
        i64 factor = xm - i;
        if(factor < 0) factor += prime_mod;
        pre[i + 1] = (i128) pre[i] * factor % prime_mod;
    }
    for(int i = k; i >= 0; i--) {
        i64 factor = xm - i;
        if(factor < 0) factor += prime_mod;
        suf[i] = (i128) suf[i + 1] * factor % prime_mod;
    }

    i64 ans = 0;
    for(int i = 0; i <= k; i++) {
        i64 term = y[i] % prime_mod;
        if(term < 0) term += prime_mod;
        term = (i128) term * pre[i] % prime_mod * suf[i + 1] % prime_mod;
        term = (i128) term * ifac[i] % prime_mod * ifac[k - i] % prime_mod;
        if((k - i) & 1) term = (prime_mod - term) % prime_mod;
        ans = (i64) (((i128) ans + term) % prime_mod);
    }
    return ans;
}
