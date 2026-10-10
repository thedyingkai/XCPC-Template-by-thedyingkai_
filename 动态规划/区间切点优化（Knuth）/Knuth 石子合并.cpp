#pragma once
#include "../../template/start.cpp"

struct KnuthMerge {
    int n;
    vector<vector<i128>> dp;
    vector<vector<int>> opt;

    // a[0..n-1] must be non-negative. Merge adjacent piles on a line.
    explicit KnuthMerge(const vector<i64>& a) : n((int) a.size()),
        dp(n, vector<i128>(n)), opt(n, vector<int>(n)) {
        vector<i128> prefix(n + 1);
        for(int i = 0; i < n; i++) {
            assert(a[i] >= 0);
            prefix[i + 1] = prefix[i] + a[i];
            opt[i][i] = i;
        }
        for(int len = 2; len <= n; len++) {
            for(int l = 0; l + len <= n; l++) {
                int r = l + len - 1;
                dp[l][r] = (i128) 1 << 120;
                int left = opt[l][r - 1], right = min(r - 1, opt[l + 1][r]);
                for(int k = left; k <= right; k++) {
                    i128 candidate = dp[l][k] + dp[k + 1][r]
                                     + prefix[r + 1] - prefix[l];
                    // Keep the rightmost optimal split consistently.
                    if(candidate <= dp[l][r]) {
                        dp[l][r] = candidate;
                        opt[l][r] = k;
                    }
                }
            }
        }
    }

    i128 answer() const { return n ? dp[0][n - 1] : 0; }
};
