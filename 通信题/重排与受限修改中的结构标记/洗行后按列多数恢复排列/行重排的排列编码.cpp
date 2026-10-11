#pragma once
#include <bits/stdc++.h>
namespace communication {

// p 是 1..n 的排列，n >= 3；信道只打乱行，保持列次序。
std::vector<std::vector<int>> encode_shuffled_rows(
    const std::vector<int> &p) {
    int n = p.size();
    auto sorted = p;
    std::sort(sorted.begin(), sorted.end());
    if (n < 3) throw std::invalid_argument("need n >= 3");
    for (int i = 0; i < n; ++i)
        if (sorted[i] != i + 1)
            throw std::invalid_argument("not a permutation");
    std::vector<std::vector<int>> rows{p};
    for (int i = 1; i < n; ++i) {
        auto row = p;
        std::swap(row[0], row[i]);
        rows.push_back(std::move(row));
    }
    return rows;
}

std::vector<int> decode_shuffled_rows(
    const std::vector<std::vector<int>> &rows) {
    int n = rows.size();
    if (n < 3) throw std::invalid_argument("need n >= 3");
    for (const auto &row : rows)
        if (int(row.size()) != n)
            throw std::invalid_argument("row length mismatch");
    std::vector<int> p(n);
    std::vector<bool> used(n + 1);
    for (int col = 1; col < n; ++col) {
        int candidate = 0, balance = 0, count = 0;
        for (const auto &row : rows) {
            if (!balance) candidate = row[col];
            balance += row[col] == candidate ? 1 : -1;
        }
        for (const auto &row : rows) count += row[col] == candidate;
        if (2 * count <= n || candidate < 1 || candidate > n ||
            used[candidate])
            throw std::invalid_argument("invalid column majority");
        p[col] = candidate;
        used[candidate] = true;
    }
    for (int x = 1; x <= n; ++x)
        if (!used[x]) p[0] = x;
    return p;
}

} // namespace communication
