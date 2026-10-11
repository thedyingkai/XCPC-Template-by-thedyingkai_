#pragma once
#include <bits/stdc++.h>
namespace interactive {

// 系数位 i 对应变量 i；RHS 可并行携带 64 个独立比特。
struct GF2System64 {
    int n, rank = 0;
    bool inconsistent = false;
    std::array<std::uint64_t, 64> row{}, rhs{};

    explicit GF2System64(int n) : n(n) {
        if (n < 0 || n > 64)
            throw std::invalid_argument("n must be in [0,64]");
    }

    // 返回是否增加秩；矛盾状态另由 inconsistent 表示。
    bool insert(std::uint64_t mask, std::uint64_t value) {
        if (n < 64 && (mask >> n) != 0)
            throw std::invalid_argument("coefficient outside domain");
        for (int i = n - 1; i >= 0; --i) {
            if (!(mask >> i & 1)) continue;
            if (!row[i]) {
                row[i] = mask;
                rhs[i] = value;
                ++rank;
                return true;
            }
            mask ^= row[i];
            value ^= rhs[i];
        }
        if (value) inconsistent = true;
        return false;
    }

    bool adds_rank(std::uint64_t mask) const {
        if (n < 64 && (mask >> n) != 0)
            throw std::invalid_argument("coefficient outside domain");
        for (int i = n - 1; i >= 0; --i)
            if (mask >> i & 1) {
                if (!row[i]) return true;
                mask ^= row[i];
            }
        return false;
    }

    // 自由变量取零；无解返回 nullopt。
    std::optional<std::vector<std::uint64_t>> solve() const {
        if (inconsistent) return std::nullopt;
        std::vector<std::uint64_t> x(n);
        for (int i = 0; i < n; ++i) {
            if (!row[i]) continue;
            x[i] = rhs[i];
            for (int j = 0; j < i; ++j)
                if (row[i] >> j & 1) x[i] ^= x[j];
        }
        return x;
    }

    bool unique() const { return !inconsistent && rank == n; }
};

} // namespace interactive
