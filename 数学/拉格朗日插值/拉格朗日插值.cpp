#include "../../template/start.cpp"

i64 lagrangePower(i64 a, i64 e, i64 mod) {
    assert(mod > 1 && e >= 0);
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

// y[i] = P(i), i = 0..n-1. Returns P(c),...,P(c+m-1).
// convolution uses 0-indexed coefficient vectors under prime_mod.
template <class Convolution>
vector<i64> lagrangeConsecutiveShift(const vector<i64>& y, i64 c, int m, i64 prime_mod,
                                     Convolution convolution) {
    int n = (int) y.size();
    assert(m >= 0);
    if(m == 0) return {};
    if(n == 0) return vector<i64>(m, 0);
    assert(prime_mod > 1 && max(n, m) < prime_mod);

    int limit = max(n, m);
    vector<i64> fac(limit, 1), ifac(limit, 1);
    for(int i = 1; i < limit; i++) fac[i] = (i128) fac[i - 1] * i % prime_mod;
    ifac[limit - 1] = lagrangePower(fac[limit - 1], prime_mod - 2, prime_mod);
    for(int i = limit - 1; i >= 1; i--) ifac[i - 1] = (i128) ifac[i] * i % prime_mod;

    auto norm = [&](i64 x) {
        x %= prime_mod;
        if(x < 0) x += prime_mod;
        return x;
    };

    // Samples -> falling-factorial coefficients.
    vector<i64> exp_neg(n), sample_egf(n);
    for(int i = 0; i < n; i++) {
        exp_neg[i] = (i & 1) ? prime_mod - ifac[i] : ifac[i];
        sample_egf[i] = (i128) norm(y[i]) * ifac[i] % prime_mod;
    }
    vector<i64> ffp = convolution(exp_neg, sample_egf);
    ffp.resize(n);

    // P(x) in the falling-factorial basis -> P(x+c).
    vector<i64> left(n), right(n);
    i64 falling = 1, cm = norm(c);
    for(int i = 0; i < n; i++) {
        left[i] = (i128) ffp[i] * fac[i] % prime_mod;
        right[i] = (i128) falling * ifac[i] % prime_mod;
        falling = (i128) falling * norm(cm - i) % prime_mod;
    }
    reverse(left.begin(), left.end());
    ffp = convolution(left, right);
    ffp.resize(n);
    reverse(ffp.begin(), ffp.end());
    for(int i = 0; i < n; i++) ffp[i] = (i128) ffp[i] * ifac[i] % prime_mod;

    // Shifted falling-factorial coefficients -> consecutive samples.
    vector<i64> exp_pos(m), useful(ffp.begin(), ffp.begin() + min(n, m));
    for(int i = 0; i < m; i++) exp_pos[i] = ifac[i];
    vector<i64> ans = convolution(exp_pos, useful);
    ans.resize(m);
    for(int i = 0; i < m; i++) ans[i] = (i128) ans[i] * fac[i] % prime_mod;
    return ans;
}
