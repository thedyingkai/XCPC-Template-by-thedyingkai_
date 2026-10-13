#include "../../template/start.cpp"

i64 phi(i64 n) {
    i64 ans = n;
    for(i64 i = 2; i <= n / i; i++) {
        if(n % i == 0) {
            ans = ans / i * (i - 1);
            while(n % i == 0) n /= i;
        }
    }
    if(n > 1) ans = ans / n * (n - 1);
    return ans;
}
i128 depow(const string& b, i64 phi) {
    i64 ans = 0;
    bool large = false;
    for(char ch : b) {
        i128 next = (i128) ans * 10 + (ch - '0');
        if(next >= phi) large = true;
        ans = next % phi;
    }
    return (i128) ans + (large ? phi : 0);
}
i64 qp(i64 a, i128 k, i64 m) {
    i64 ans = 1 % m;
    a %= m;
    if(a < 0) a += m;
    while(k) {
        if(k & 1) ans = (i128) ans * a % m;
        a = (i128) a * a % m;
        k >>= 1;
    }
    return ans;
}
i64 exEulerPow(i64 a, const string& b, i64 m) {
    if(m == 1) return 0;
    i64 ph = phi(m);
    return qp(a, depow(b, ph), m);
}
