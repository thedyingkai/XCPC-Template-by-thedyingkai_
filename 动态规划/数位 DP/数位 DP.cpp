#pragma once
#include "../../template/start.cpp"


long long dig[13];
long long memo[13][13];      // memo[pos][last]，仅 tight=false 且已开始填数时有效

long long dfs(int pos, int last, bool tight, bool lead) {
    if (pos == 0) return 1;                       // 填完，算一个数（含全 0）
    if (!tight && !lead && memo[pos][last] != -1) return memo[pos][last];

    int up = tight ? (int)dig[pos] : 9;
    long long res = 0;
    for (int d = 0; d <= up; ++d) {
        bool nt = tight && (d == up);
        if (lead) {
            if (d == 0) res += dfs(pos - 1, 10, nt, true);    // 仍是前导零
            else        res += dfs(pos - 1, d,  nt, false);
        } else {
            if (abs(d - last) < 2) continue;                  // 差 < 2 不合法
            res += dfs(pos - 1, d, nt, false);
        }
    }
    if (!tight && !lead) memo[pos][last] = res;   // 前导零状态不可记忆
    return res;
}

long long solve(long long x) {                    // [0, x] 中的 windy 数个数（含 0）
    if (x < 0) return 0;
    long long t[13]; int c = 0;
    if (x == 0) t[c++] = 0;                       // x=0 需单独补一位
    while (x > 0) { t[c++] = x % 10; x /= 10; }
    for (int i = 0; i < c; ++i) dig[c - i] = t[i];   // dig[c] 是最高位
    memset(memo, -1, sizeof memo);
    return dfs(c, 10, true, true);
}

void NUMBER_DP() {
    long long a, b;
    scanf("%lld %lld", &a, &b);
    printf("%lld\n", solve(b) - solve(a - 1));    // 两个 solve 都含 0，自动抵消
}
