#include <template/start.cpp>

vector<i64> pre;
void PRE() {
    // pre() 是 f(d) 的前缀和函数
}
void LuoTianyi() {
    int n, m;
    cin >> n >> m;
    cout << [&]() -> i64 {
        if(n > m) swap(n, m);
        i64 ans = 0;
        // 求 sum_{d=1}^{\min(n,m)} f(d) ┕ \frac{n}{d} ┙ ┕ \frac{m}{d} ┙
        for(int l = 1, r; l <= n; l = r + 1) {
            r = min(n / (n / l), m / (m / l));
            ans += (pre[r] - pre[l - 1]) * (n / l) * (m / l);
        }
        return ans;
    }() << endl;
}
void another() {
    int n = 1e5;
    vector<i64> G(n + 1);
    // 求 G[i]=sum_{k=1}^{i} ┕ \frac{i}{k} ┙
    for(int i = 1; i <= n; i++)
        for(int l = 1, r; l <= i; l = r + 1) {
            r = i / (i / l);
            G[i] += (r + 1 - l) * (i / l);
        }
}
