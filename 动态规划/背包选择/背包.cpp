#pragma once
#include "../../template/start.cpp"

struct Knapsack {
    static constexpr i128 NEG = -((i128) 1 << 120);
    int capacity;
    vector<i128> dp;

    // exact=true: dp[j] means volume exactly j; otherwise volume at most j.
    Knapsack(int capacity_, bool exact = false) : capacity(capacity_) {
        assert(capacity >= 0);
        dp.assign(capacity + 1, exact ? NEG : 0);
        dp[0] = 0;
    }

    void add01(int volume, i128 value) {
        assert(volume > 0);
        for(int j = capacity; j >= volume; j--)
            if(dp[j - volume] != NEG)
                dp[j] = max(dp[j], dp[j - volume] + value);
    }

    void addComplete(int volume, i128 value) {
        assert(volume > 0);
        for(int j = volume; j <= capacity; j++)
            if(dp[j - volume] != NEG)
                dp[j] = max(dp[j], dp[j - volume] + value);
    }

    void addBoundedBinary(int volume, i128 value, i64 count) {
        assert(volume > 0 && count >= 0);
        count = min(count, (i64) capacity / volume);
        for(i64 block = 1; count > 0; block <<= 1) {
            i64 take = min(block, count);
            add01((int) (take * volume), take * value);
            count -= take;
        }
    }

    void addBoundedQueue(int volume, i128 value, i64 count) {
        assert(volume > 0 && count >= 0);
        if(volume > capacity || count == 0) return;
        int limit = (int) min(count, (i64) capacity / volume);
        vector<i128> old = dp;
        for(int r = 0; r < volume; r++) {
            deque<pair<int, i128>> q;
            for(int t = 0; t <= (capacity - r) / volume; t++) {
                int j = r + t * volume;
                while(!q.empty() && q.front().first < t - limit)
                    q.pop_front();
                if(old[j] != NEG) {
                    i128 candidate = old[j] - (i128) t * value;
                    while(!q.empty() && q.back().second <= candidate)
                        q.pop_back();
                    q.push_back({t, candidate});
                }
                dp[j] = q.empty() ? NEG : q.front().second + (i128) t * value;
            }
        }
    }
};
