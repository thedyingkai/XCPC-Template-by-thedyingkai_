#include "../../template/start.cpp"

i64 exbsgs(i64 a, i64 b, i64 p) {
    assert(p > 0);
    auto mul_mod = [](i64 x, i64 y, i64 mod) { return (i64) ((i128) x * y % mod); };
    a %= p, b %= p;
    if(a < 0) a += p;
    if(b < 0) b += p;
    if(b == 1 || p == 1) return 0;
    i64 d, k = 0, A = 1;
    while(1) {
        d = gcd(a, p);
        if(d == 1) break;
        if(b % d) return -1;
        k++, b /= d, p /= d;
        A = mul_mod(A, a / d, p);
        if(A == b) return k;
    }
    i64 m = sqrtl((long double) p);
    while((i128) m * m < p) m++;
    while(m > 0 && (i128) (m - 1) * (m - 1) >= p) m--;
    i64 t = b;
    unordered_map<i64, i64> mp;
    mp[b] = 0;
    for(int j = 1; j < m; j++) {
        t = mul_mod(t, a, p);
        mp[t] = j;
    }
    i64 sum = 1;
    for(int i = 1; i <= m; i++) sum = mul_mod(sum, a, p);
    t = A;
    for(int i = 1; i <= m; i++) {
        t = mul_mod(t, sum, p);
        if(mp.count(t)) return i * m - mp[t] + k;
    }
    return -1;
}
