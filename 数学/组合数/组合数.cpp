#include "../../template/start.cpp"

// start: comb
struct Comb {
    i64 mod = 1;
    vector<i64> fac, ifac;

    static i64 power(i64 a, i64 e, i64 mod) {
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

    void init(int n, i64 prime_mod) {
        assert(n >= 0 && prime_mod > 1 && (i64) n < prime_mod);
        mod = prime_mod;
        fac.assign(n + 1, 1);
        ifac.assign(n + 1, 1);
        for(int i = 1; i <= n; i++) fac[i] = (i128) fac[i - 1] * i % mod;
        ifac[n] = power(fac[n], mod - 2, mod);
        for(int i = n; i >= 1; i--) ifac[i - 1] = (i128) ifac[i] * i % mod;
    }

    i64 C(i64 n, i64 k) const {
        if(k < 0 || k > n || n < 0 || n >= (i64) fac.size()) return 0;
        return (i128) fac[n] * ifac[k] % mod * ifac[n - k] % mod;
    }

    i64 A(i64 n, i64 k) const {
        if(k < 0 || k > n || n < 0 || n >= (i64) fac.size()) return 0;
        return (i128) fac[n] * ifac[n - k] % mod;
    }

    // x_1 + ... + x_boxes = sum, x_i >= 0.
    i64 starsBars(i64 sum, i64 boxes) const {
        if(boxes == 0) return sum == 0;
        return C(sum + boxes - 1, boxes - 1);
    }
};
// end: comb

// start: batch-inverse
// All a[i] must be nonzero modulo prime_mod.
vector<i64> batchInverse(const vector<i64>& a, i64 prime_mod) {
    assert(prime_mod > 1);
    int n = (int) a.size();
    vector<i64> pre(n + 1, 1), ans(n);
    for(int i = 0; i < n; i++) {
        i64 x = a[i] % prime_mod;
        if(x < 0) x += prime_mod;
        pre[i + 1] = (i128) pre[i] * x % prime_mod;
    }
    i64 suf = Comb::power(pre[n], prime_mod - 2, prime_mod);
    for(int i = n - 1; i >= 0; i--) {
        ans[i] = (i128) pre[i] * suf % prime_mod;
        i64 x = a[i] % prime_mod;
        if(x < 0) x += prime_mod;
        suf = (i128) suf * x % prime_mod;
    }
    return ans;
}
// end: batch-inverse
