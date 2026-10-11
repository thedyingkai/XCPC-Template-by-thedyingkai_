#pragma once
#include <bits/stdc++.h>
namespace communication {

// 完整排列 1..n；advice = [pos(1)<pos(n)]。
// spread(l,r) 为 0-based 闭区间的 max-min。
// 返回最大值 n 的 0-based 位置，至多 ceil(log2 n) 问。
template<class Spread>
int locate_maximum(int n, bool advice, Spread spread) {
    if (n < 1) throw std::invalid_argument("invalid permutation size");
    int lo = 0, hi = n - 1;
    if (advice) {
        while (lo < hi) {
            int mid = lo + (hi - lo) / 2;
            if (spread(0, mid) == n - 1) hi = mid;
            else lo = mid + 1;
        }
    } else {
        while (lo < hi) {
            int mid = lo + (hi - lo + 1) / 2;
            if (spread(mid, n - 1) == n - 1) lo = mid;
            else hi = mid - 1;
        }
    }
    return lo;
}

} // namespace communication
