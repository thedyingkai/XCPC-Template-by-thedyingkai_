#pragma once
#include <bits/stdc++.h>
namespace interactive {

// ask(a) = s(x+a)，每次均针对原始 x，0 <= x < 10^18。
// 至多 73 问；实际询问的 a 也小于 10^18。
template<class Ask>
std::uint64_t recover_digit_sum(Ask ask) {
    int baseline = ask(std::uint64_t(0));
    std::uint64_t answer = 0, power = 1;
    for (int i = 0; i < 18; ++i) {
        int lo = 0, hi = 10; // lo 不进位，hi 必进位。
        while (hi - lo > 1) {
            int mid = (lo + hi) / 2;
            if (ask(power * mid) == baseline + mid) lo = mid;
            else hi = mid;
        }
        answer += power * (10 - hi);
        if (i != 17) power *= 10;
    }
    return answer;
}

} // namespace interactive
