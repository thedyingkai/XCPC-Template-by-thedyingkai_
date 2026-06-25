#include <template/start.cpp>

i64 qp(i64 a, i64 b, i64 p) {
    i64 res = 1;
    while(b > 0) {
        if(b & 1) res = res * a % p;
        a = a * a % p;
        b >>= 1;
    }
    return res % p;
}
struct Lucas {
    vector<i64> f, g;
    void init(int p) {
        f.resize(p + 1), g.resize(p + 1);
        f[0] = g[0] = 1;
        for(int i = 1; i <= p; i++) {
            f[i] = f[i - 1] * i % p;
            g[i] = g[i - 1] * qp(i, p - 2, p) % p;
        }
    }
    i64 getC(int n, int m, int p) {
        if(m > n) return 0;
        return f[n] * g[m] % p * g[n - m] % p;
    }
    i64 C(i64 n, i64 m, i64 p) {
        if(m == 0) return 1;
        return C(n / p, m / p, p) * getC(n % p, m % p, p) % p;
    }
} lucas;
