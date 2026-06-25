#include <template/start.cpp>

namespace PollardRho {
static mt19937_64 rng(chrono::high_resolution_clock::now().time_since_epoch().count());
i64 mul_mod(i64 a, i64 b, i64 m) { return (i64) ((i128) a * b % m); }
i64 pow_mod(i64 a, i64 e, i64 m) {
    i64 r = 1;
    a %= m;
    while(e) {
        if(e & 1) r = mul_mod(r, a, m);
        a = mul_mod(a, a, m), e >>= 1;
    }
    return r;
}
bool isPrime(i64 n) {
    if(n < 2) return 0;
    for(i64 p : {2LL, 3LL, 5LL, 7LL, 11LL, 13LL, 17LL, 19LL, 23LL, 29LL, 31LL, 37LL})
        if(n % p == 0) return n == p;
    i64 d = n - 1, s = 0;
    while((d & 1) == 0) d >>= 1, s++;
    auto check = [&](i64 a) {
        i64 x = pow_mod(a, d, n);
        if(x == 1 || x == n - 1) return 1;
        for(i64 i = 1; i < s; i++) {
            x = mul_mod(x, x, n);
            if(x == n - 1) return 1;
        }
        return 0;
    };
    for(i64 a : {2LL, 325LL, 9375LL, 28178LL, 450775LL, 9780504LL, 1795265022LL})
        if(a % n != 0 && !check(a)) return 0;
    return 1;
}
i64 pollard(i64 n) {
    if(n % 2 == 0) return 2;
    uniform_int_distribution<i64> distC(1, n - 1), distX(0, n - 1);
    i64 c = distC(rng), x = distX(rng), y = x, d = 1;
    auto f = [&](i64 v) { return (mul_mod(v, v, n) + c) % n; };
    while(d == 1) {
        x = f(x), y = f(f(y));
        i64 diff = x > y ? x - y : y - x;
        d = gcd(diff, n);
    }
    return (d == n ? pollard(n) : d);
}
void factorRec(i64 n, map<i64, int>& mp) {
    if(n == 1) return;
    if(isPrime(n))
        mp[n]++;
    else {
        i64 d = pollard(n);
        factorRec(d, mp);
        factorRec(n / d, mp);
    }
}
map<i64, int> factor(i64 n) {
    map<i64, int> mp;
    factorRec(n, mp);
    return mp;
}
} // namespace PollardRho

int main() {
    i64 n;
    cin >> n;

    if(PollardRho::isPrime(n)) {
        cout << "Prime" << endl;
        return 0;
    }
    auto fac = PollardRho::factor(n);
    i64 Max = 0;
    // 输出最大质因子
    for(auto& [x, y] : fac) Max = max(Max, x);

    cout << Max << endl;
}
