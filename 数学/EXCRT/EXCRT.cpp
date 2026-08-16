#include "../../template/start.cpp"
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
        i128 delta = (i128) r2 - r1;
        if(delta % d) return -1;
        i64 mod = m2 / d;
        i128 step = (i128) p * (delta / d) % mod;
        if(step < 0) step += mod;
        p = step;
        i128 next_mod = (i128) m1 / d * m2;
        i128 next_r = ((i128) m1 * p + r1) % next_mod;
        if(next_r < 0) next_r += next_mod;
        r1 = next_r;
        m1 = next_mod;
    }
    return r1;
}
