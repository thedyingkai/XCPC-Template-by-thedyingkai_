#pragma once
#include "../../template/start.cpp"

// Return zero-based indices of one longest subsequence.
// strict=false requests a longest non-decreasing subsequence.
template<class T>
vector<int> longestIncreasingSubsequence(const vector<T>& a, bool strict = true) {
    vector<T> tail;
    vector<int> position, previous(a.size(), -1);
    for(int i = 0; i < (int) a.size(); i++) {
        int p = (int) ((strict ? lower_bound(tail.begin(), tail.end(), a[i])
                              : upper_bound(tail.begin(), tail.end(), a[i]))
                       - tail.begin());
        if(p) previous[i] = position[p - 1];
        if(p == (int) tail.size()) {
            tail.push_back(a[i]);
            position.push_back(i);
        } else {
            tail[p] = a[i];
            position[p] = i;
        }
    }
    vector<int> answer;
    if(!position.empty())
        for(int u = position.back(); u != -1; u = previous[u])
            answer.push_back(u);
    reverse(answer.begin(), answer.end());
    return answer;
}
