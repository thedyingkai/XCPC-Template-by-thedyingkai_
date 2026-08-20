#include "../../template/start.cpp"

i64 qp(i64 a, i64 b, i64 p) {
    assert(p > 1 && b >= 0);
    i64 res = 1 % p;
    a %= p;
    if(a < 0) a += p;
    while(b > 0) {
        if(b & 1) res = (i128) res * a % p;
        a = (i128) a * a % p;
        b >>= 1;
    }
    return res;
}
struct Lucas {
    vector<int> f, g;
    int mod = 1;
    void init(int p, int max_digit = -1) {
        assert(p > 1);
        if(max_digit < 0) max_digit = p - 1;
        assert(0 <= max_digit && max_digit < p);
        mod = p;
        f.assign(max_digit + 1, 1);
        g.assign(max_digit + 1, 1);
        for(int i = 1; i <= max_digit; i++) f[i] = (i64) f[i - 1] * i % p;
        g[max_digit] = qp(f[max_digit], p - 2, p);
        for(int i = max_digit; i >= 1; i--) g[i - 1] = (i64) g[i] * i % p;
    }
    i64 getC(int n, int m, int p) {
        if(m < 0 || n < 0 || m > n) return 0;
        assert(p == mod && n < p);
        if(n < (int) f.size()) return (i64) f[n] * g[m] % p * g[n - m] % p;
        m = min(m, n - m);
        i64 numerator = 1, denominator = 1;
        for(int i = 1; i <= m; i++) {
            numerator = numerator * (n - m + i) % p;
            denominator = denominator * i % p;
        }
        return numerator * qp(denominator, p - 2, p) % p;
    }
    i64 C(i64 n, i64 m, i64 p) {
        if(n < 0 || m < 0 || m > n) return 0;
        assert(p == mod);
        if(m == 0) return 1;
        return C(n / p, m / p, p) * getC(n % p, m % p, p) % p;
    }
} lucas;
