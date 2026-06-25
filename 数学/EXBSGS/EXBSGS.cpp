#include <template/start.cpp>

i64 exbsgs(i64 a, i64 b, i64 p) {
    a %= p, b %= p;
    if(b == 1 || p == 1) return 0;
    i64 d, k = 0, A = 1;
    while(1) {
        d = gcd(a, p);
        if(d == 1) break;
        if(b % d) return -1;
        k++, b /= d, p /= d;
        A = A * (a / d) % p;
        if(A == b) return k;
    }
    i64 m = ceil(sqrt(p)), t = b;
    unordered_map<int, int> mp;
    mp[b] = 0;
    for(int j = 1; j < m; j++) {
        t = t * a % p;
        mp[t] = j;
    }
    i64 sum = 1;
    for(int i = 1; i <= m; i++) sum = sum * a % p;
    t = A;
    for(int i = 1; i <= m; i++) {
        t = t * sum % p;
        if(mp.count(t)) return i * m - mp[t] + k;
    }
    return -1;
}
