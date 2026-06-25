#include <template/start.cpp>

i64 phi(i64 n) {
    i64 ans = n;
    for(int i = 2; i * i <= n; i++) {
        if(n % i == 0) {
            ans = ans / i * (i - 1);
            while(n % i == 0) n /= i;
        }
    }
    if(n > 1) ans = ans / n * (n - 1);
    return ans;
}
i64 depow(string b, i64 phi) {
    i64 ans = 0;
    bool flg = 0;
    for(int i = 0; i < b.length(); i++) {
        ans = ans * 10 + (b[i] - '0');
        if(ans > phi) {
            flg = 1;
            ans %= phi;
        }
    }
    if(flg) ans += phi;
    return ans;
}
i64 qp(i64 a, i64 k, i64 m) {
    i64 ans = 1;
    while(k) {
        if(k & 1) ans = (ans * a) % m;
        a = (a * a) % m;
        k >>= 1;
    }
    return ans % m;
}
ans = qp(a, depow(b, phi(m)), m);
