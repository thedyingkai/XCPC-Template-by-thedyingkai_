#pragma once
#include <bits/stdc++.h>
namespace interactive {

// 固定实例、只读查询；reply[q][i] 是查询 q 对候选 i 的回包。
// 搜索最坏深度，时间和存储均可能指数增长。
struct Minimax {
    static constexpr int INF = 1000000000;
    struct Decision { int depth, query; };
    std::vector<int> category;
    std::vector<std::vector<int>> reply;
    std::unordered_map<std::uint64_t, Decision> memo;

    Minimax(std::vector<int> category,
                      std::vector<std::vector<int>> reply)
        : category(std::move(category)), reply(std::move(reply)) {
        if (this->category.empty() || this->category.size() > 64)
            throw std::invalid_argument("need 1..64 candidates");
        for (const auto &q : this->reply)
            if (q.size() != this->category.size())
                throw std::invalid_argument("reply size mismatch");
    }

    std::uint64_t full_set() const {
        int n = category.size();
        return n == 64 ? ~std::uint64_t(0)
                       : (std::uint64_t(1) << n) - 1;
    }

    Decision solve(std::uint64_t s) {
        if (!s || (s & ~full_set()))
            throw std::invalid_argument("invalid candidate set");
        if (auto it = memo.find(s); it != memo.end())
            return it->second;
        int first = std::countr_zero(s);
        bool pure = true;
        for (auto t = s; t; t &= t - 1)
            if (category[std::countr_zero(t)] != category[first])
                pure = false;
        if (pure) return memo[s] = {0, -1};
        Decision best{INF, -1};
        for (int q = 0; q < reply.size(); ++q) {
            std::map<int, std::uint64_t> buckets;
            for (auto t = s; t; t &= t - 1) {
                int i = std::countr_zero(t);
                buckets[reply[q][i]] |= std::uint64_t(1) << i;
            }
            if (buckets.size() == 1) continue;
            int worst = 0;
            for (auto [value, subset] : buckets) {
                worst = std::max(worst, solve(subset).depth);
                if (worst >= best.depth - 1) break;
            }
            if (worst < INF && worst + 1 < best.depth)
                best = {worst + 1, q};
        }
        return memo[s] = best;
    }

    std::uint64_t advance(std::uint64_t s, int q, int value) const {
        if (q < 0 || q >= reply.size())
            throw std::invalid_argument("invalid query");
        std::uint64_t next = 0;
        for (auto t = s; t; t &= t - 1) {
            int i = std::countr_zero(t);
            if (i >= category.size())
                throw std::invalid_argument("invalid candidate set");
            if (reply[q][i] == value)
                next |= std::uint64_t(1) << i;
        }
        return next; // 0 表示回复与已有历史矛盾。
    }
};

} // namespace interactive
