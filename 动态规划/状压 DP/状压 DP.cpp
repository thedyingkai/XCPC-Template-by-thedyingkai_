#pragma once
#include "../../template/start.cpp"

int n, K;
vector<int> ok, cnt;              // 合法行状态 + 各自国王数
long long cur[512][85], nxt[512][85];
void solve() {
    scanf("%d %d", &n, &K);
    for (int m = 0; m < (1 << n); ++m) {
        if (m & (m << 1)) continue;        // 行内不能有相邻的 1
        ok.push_back(m);
        cnt.push_back(__builtin_popcount(m));
    }
    int M = ok.size();
    for (int j = 0; j < M; ++j)
        if (cnt[j] <= K) cur[j][cnt[j]] = 1;      // 第 1 行
    for (int row = 2; row <= n; ++row) {
        memset(nxt, 0, sizeof nxt);
        for (int j = 0; j < M; ++j)               // 本行状态
            for (int p = 0; p < M; ++p) {         // 上一行状态
                if (ok[p] & ok[j]) continue;                  // 正上方
                if ((ok[p] << 1) & ok[j]) continue;           // 左上
                if (ok[p] & (ok[j] << 1)) continue;           // 右上
                for (int k = 0; k + cnt[j] <= K; ++k)
                    if (cur[p][k]) nxt[j][k + cnt[j]] += cur[p][k];
            }
        memcpy(cur, nxt, sizeof cur);
    }
    long long ans = 0;
    for (int j = 0; j < M; ++j) ans += cur[j][K];
    printf("%lld\n", ans);
}