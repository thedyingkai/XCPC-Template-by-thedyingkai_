#pragma once

#include "../../template/start.cpp"

struct MeetInTheMiddle {
    static vector<i64> subsetSums(const vector<i64>& a) {
        vector<i64> sum(1, 0);
        for(i64 value : a) {
            int oldSize = (int) sum.size();
            sum.resize(oldSize * 2);
            for(int mask = 0; mask < oldSize; mask++) sum[oldSize + mask] = sum[mask] + value;
        }
        return sum;
    }

    static optional<i64> maxSubsetSumAtMost(const vector<i64>& a, i64 limit) {
        int middle = (int) a.size() / 2;
        vector<i64> left = subsetSums(vector<i64>(a.begin(), a.begin() + middle));
        vector<i64> right = subsetSums(vector<i64>(a.begin() + middle, a.end()));
        sort(right.begin(), right.end());
        optional<i64> answer;
        for(i64 x : left) {
            i128 threshold = (i128) limit - x;
            auto it = threshold < numeric_limits<i64>::min() ? right.begin()
                : threshold >= numeric_limits<i64>::max() ? right.end()
                : upper_bound(right.begin(), right.end(), (i64) threshold);
            if(it == right.begin()) continue;
            i64 value = x + *prev(it);
            if(!answer || value > *answer) answer = value;
        }
        return answer;
    }

    static i64 countSubsetSumsAtMost(const vector<i64>& a, i64 limit) {
        int middle = (int) a.size() / 2;
        vector<i64> left = subsetSums(vector<i64>(a.begin(), a.begin() + middle));
        vector<i64> right = subsetSums(vector<i64>(a.begin() + middle, a.end()));
        sort(right.begin(), right.end());
        i64 answer = 0;
        for(i64 x : left) {
            i128 threshold = (i128) limit - x;
            if(threshold < numeric_limits<i64>::min()) continue;
            if(threshold >= numeric_limits<i64>::max()) answer += (i64) right.size();
            else answer += upper_bound(right.begin(), right.end(), (i64) threshold) - right.begin();
        }
        return answer;
    }
};
