#pragma once
#include <bits/stdc++.h>
namespace interactive {

// iterate(k, x) 返回固定隐藏函数的 f^k(x)。
// 返回 (c, r)，满足 f^c(r) = c；编号为 1..n。
template<class Iterate>
std::pair<int, int> hash_witness(int n, Iterate iterate, int x = 1) {
    if (n < 1 || x < 1 || x > n)
        throw std::invalid_argument("invalid domain");
    int c = iterate(n, x);
    if (c < 1 || c > n)
        throw std::runtime_error("invalid reply");
    int r = (c == n ? x : iterate(n - c, x));
    return {c, r};
}

} // namespace interactive
