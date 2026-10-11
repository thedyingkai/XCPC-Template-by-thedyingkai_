#pragma once
#include <bits/stdc++.h>
namespace interactive {

// 环长 n <= upper <= 10^9，标签恰为 1..n。
// walk(step) 移动并返回新标签；rng 由调用者提供种子。
// 无证据则返回 nullopt；最多 samples+baby+giant 问。
template<class Walk, class RNG>
std::optional<std::uint64_t> identify_cycle(
    Walk walk, RNG &rng, std::uint64_t upper = 1000000000,
    int samples = 3333, int baby = 3333, int giant = 3334) {
    if (!upper || upper > 1000000000 || samples < 1 ||
        baby < 1 || giant < 1)
        throw std::invalid_argument("invalid parameters");
    std::uniform_int_distribution<std::uint64_t> jump(1, upper);
    std::uint64_t m = 0;
    for (int i = 0; i < samples; ++i)
        m = std::max(m, std::uint64_t(walk(jump(rng))));
    if (!m || m > upper)
        throw std::runtime_error("label outside domain");
    std::unordered_map<std::uint64_t, int> seen;
    for (int t = 1; t <= baby; ++t) {
        std::uint64_t label = walk(1);
        auto [it, fresh] = seen.emplace(label, t);
        if (!fresh) return std::uint64_t(t - it->second);
    }
    for (int j = 0; j < giant; ++j) {
        std::uint64_t label = walk(j == 0 ? m
                                          : std::uint64_t(baby));
        if (auto it = seen.find(label); it != seen.end()) {
            std::uint64_t t = std::uint64_t(baby) + m
                           + std::uint64_t(j) * baby;
            return t - it->second;
        }
    }
    return std::nullopt;
}

} // namespace interactive
