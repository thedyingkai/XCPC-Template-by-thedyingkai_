#include <template/start.cpp>
i64 exgcd(i64 a, i64 b, i64& x, i64& y) {
    if(b == 0) {
        x = 1, y = 0;
        return a;
    }
    i64 x1, y1, d;
    d = exgcd(b, a % b, x1, y1);
    x = y1, y = x1 - a / b * y1;
    return d;
}
i64 excrt(vector<i64>& m, vector<i64>& r, int n) {
    i64 m1 = m[1], m2, r1 = r[1], r2, p, q;
    for(int i = 2; i <= n; i++) {
        m2 = m[i], r2 = r[i];
        i64 d = exgcd(m1, m2, p, q);
        if((r2 - r1) % d) return -1;
        p = p * (r2 - r1) / d;
        p = (p % (m2 / d) + m2 / d) % (m2 / d);
        r1 = m1 * p + r1, m1 = (i128) m1 * m2 / d;
    }
    return (r1 % m1 + m1) % m1;
}
