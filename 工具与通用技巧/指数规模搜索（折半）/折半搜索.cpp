#pragma once

#include "../../template/start.cpp"

struct MITM {
    static vector<i64> subsetSums(const vector<i64>& a) {
        vector<i64> sum(1, 0);
        for(i64 value : a) {
            int oldSize = sum.size();
            sum.resize(oldSize * 2);
            for(int mask = 0; mask < oldSize; mask++) sum[oldSize + mask] = sum[mask] + value;
        }
        return sum;
    }

    static optional<i64> maxSubsetSum(const vector<i64>& a, i64 limit) {
        int middle = a.size() / 2;
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

    static i64 countSubsetSum(const vector<i64>& a, i64 limit) {
        int middle = a.size() / 2;
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

    static vector<int> maxIndependent(const vector<u64>& adjacency) {
        int n = adjacency.size();
        int leftSize = n / 2, rightSize = n - leftSize;
        int statesL = 1 << leftSize, statesR = 1 << rightSize;
        vector<unsigned char> okR(statesR), bestR(statesR);
        vector<unsigned> maskR(statesR);
        okR[0] = 1;
        for(int mask = 1; mask < statesR; mask++) {
            int bit = countr_zero((unsigned) mask);
            int rest = mask ^ (1 << bit);
            u64 neighbor = adjacency[leftSize + bit] >> leftSize;
            okR[mask] = okR[rest] && !(neighbor & (unsigned) rest);
            if(okR[mask]) {
                bestR[mask] = (unsigned char) popcount((unsigned) mask);
                maskR[mask] = (unsigned) mask;
            }
        }
        for(int bit = 0; bit < rightSize; bit++)
            for(int mask = 0; mask < statesR; mask++)
                if((mask >> bit & 1) && bestR[mask ^ (1 << bit)] > bestR[mask]) {
                    bestR[mask] = bestR[mask ^ (1 << bit)];
                    maskR[mask] = maskR[mask ^ (1 << bit)];
                }

        vector<unsigned char> okL(statesL);
        vector<unsigned> banR(statesL);
        okL[0] = 1;
        int ansSize = bestR.back();
        unsigned ansL = 0, ansR = maskR.back();
        unsigned allRight = (1u << rightSize) - 1;
        for(int mask = 1; mask < statesL; mask++) {
            int bit = countr_zero((unsigned) mask);
            int rest = mask ^ (1 << bit);
            okL[mask] = okL[rest] && !(adjacency[bit] & (unsigned) rest);
            banR[mask] = banR[rest] | (unsigned) (adjacency[bit] >> leftSize);
            if(!okL[mask]) continue;
            unsigned available = allRight & ~banR[mask];
            int size = popcount((unsigned) mask) + bestR[available];
            if(size > ansSize) {
                ansSize = size;
                ansL = (unsigned) mask;
                ansR = maskR[available];
            }
        }
        vector<int> answer;
        answer.reserve(ansSize);
        for(int i = 0; i < leftSize; i++)
            if(ansL >> i & 1) answer.push_back(i);
        for(int i = 0; i < rightSize; i++)
            if(ansR >> i & 1) answer.push_back(leftSize + i);
        return answer;
    }
};
