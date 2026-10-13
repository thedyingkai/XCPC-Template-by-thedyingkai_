#pragma once
#include <bits/stdc++.h>
namespace communication {

// count 为 2 的幂，硬币位置及目标编号均为 0..count-1。
int coin_syndrome(const std::vector<int> &heads) {
    int n = heads.size();
    if (n < 1 || (n & (n - 1)))
        throw std::invalid_argument("coin count must be a power of two");
    int syndrome = 0;
    for (int i = 0; i < n; ++i) {
        if (heads[i] != 0 && heads[i] != 1)
            throw std::invalid_argument("nonbinary coin");
        if (heads[i]) syndrome ^= i;
    }
    return syndrome;
}

// 必须翻恰一枚时也合法：翻 0 号不会改变综合。
int coin_to_flip(const std::vector<int> &heads, int target) {
    int syndrome = coin_syndrome(heads);
    if (target < 0 || target >= heads.size())
        throw std::invalid_argument("target outside domain");
    return syndrome ^ target;
}

} // namespace communication
