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

    static vector<int> maximumIndependentSet(const vector<u64>& adjacency) {
        int n = (int) adjacency.size();
        assert(n <= 40);
        for(int i = 0; i < n; i++) {
            assert(!(adjacency[i] >> i & 1ULL));
            for(int j = 0; j < n; j++)
                assert(((adjacency[i] >> j) & 1ULL) == ((adjacency[j] >> i) & 1ULL));
        }
        int leftSize = n / 2, rightSize = n - leftSize;
        int leftStates = 1 << leftSize, rightStates = 1 << rightSize;
        vector<unsigned char> rightIndependent(rightStates), rightBestSize(rightStates);
        vector<unsigned> rightBestMask(rightStates);
        rightIndependent[0] = 1;
        for(int mask = 1; mask < rightStates; mask++) {
            int bit = countr_zero((unsigned) mask);
            int rest = mask ^ (1 << bit);
            u64 neighbor = adjacency[leftSize + bit] >> leftSize;
            rightIndependent[mask] = rightIndependent[rest] && !(neighbor & (unsigned) rest);
            if(rightIndependent[mask]) {
                rightBestSize[mask] = (unsigned char) popcount((unsigned) mask);
                rightBestMask[mask] = (unsigned) mask;
            }
        }
        for(int bit = 0; bit < rightSize; bit++)
            for(int mask = 0; mask < rightStates; mask++)
                if((mask >> bit & 1) && rightBestSize[mask ^ (1 << bit)] > rightBestSize[mask]) {
                    rightBestSize[mask] = rightBestSize[mask ^ (1 << bit)];
                    rightBestMask[mask] = rightBestMask[mask ^ (1 << bit)];
                }

        vector<unsigned char> leftIndependent(leftStates);
        vector<unsigned> blockedRight(leftStates);
        leftIndependent[0] = 1;
        int answerSize = rightBestSize.back();
        unsigned answerLeft = 0, answerRight = rightBestMask.back();
        unsigned allRight = (1u << rightSize) - 1;
        for(int mask = 1; mask < leftStates; mask++) {
            int bit = countr_zero((unsigned) mask);
            int rest = mask ^ (1 << bit);
            leftIndependent[mask] = leftIndependent[rest] && !(adjacency[bit] & (unsigned) rest);
            blockedRight[mask] = blockedRight[rest] | (unsigned) (adjacency[bit] >> leftSize);
            if(!leftIndependent[mask]) continue;
            unsigned available = allRight & ~blockedRight[mask];
            int size = popcount((unsigned) mask) + rightBestSize[available];
            if(size > answerSize) {
                answerSize = size;
                answerLeft = (unsigned) mask;
                answerRight = rightBestMask[available];
            }
        }
        vector<int> answer;
        answer.reserve(answerSize);
        for(int i = 0; i < leftSize; i++)
            if(answerLeft >> i & 1) answer.push_back(i);
        for(int i = 0; i < rightSize; i++)
            if(answerRight >> i & 1) answer.push_back(leftSize + i);
        return answer;
    }
};
