#pragma once
#include <bits/stdc++.h>
#include <boost/multiprecision/cpp_int.hpp>
namespace communication {

using boost::multiprecision::cpp_int;

cpp_int multiset_choose(int n, int k) {
    if (k < 0 || n < k) return 0;
    k = std::min(k, n - k);
    cpp_int c = 1;
    for (int i = 1; i <= k; ++i)
        c = c * (n - k + i) / i;
    return c;
}

// symbols 使用 0..q-1 编号；允许接收端传入乱序序列。
cpp_int rank_multiset(std::vector<int> symbols, int q) {
    if (q < 1) throw std::invalid_argument("invalid alphabet");
    std::sort(symbols.begin(), symbols.end());
    cpp_int rank = 0;
    for (int i = 0; i < int(symbols.size()); ++i) {
        if (symbols[i] < 0 || symbols[i] >= q)
            throw std::invalid_argument("symbol outside alphabet");
        rank += multiset_choose(symbols[i] + i, i + 1);
    }
    return rank;
}

std::vector<int> unrank_multiset(cpp_int rank, int length, int q) {
    if (length < 0 || q < 1 || rank < 0 ||
        rank >= multiset_choose(length + q - 1, length))
        throw std::invalid_argument("rank outside capacity");
    std::vector<int> symbols(length);
    int upper = length + q - 2;
    for (int k = length; k >= 1; --k) {
        int lo = k - 1, hi = upper;
        while (lo < hi) {
            int mid = lo + (hi - lo + 1) / 2;
            if (multiset_choose(mid, k) <= rank) lo = mid;
            else hi = mid - 1;
        }
        rank -= multiset_choose(lo, k);
        symbols[k - 1] = lo - (k - 1);
        upper = lo - 1;
    }
    return symbols;
}

// 连续编号所有长度 0..max_length 的多重集。
std::vector<int> encode_variable_multiset(
    cpp_int rank, int q, int max_length) {
    if (q < 1 || max_length < 0 || rank < 0)
        throw std::invalid_argument("invalid parameters");
    for (int len = 0; len <= max_length; ++len) {
        cpp_int capacity = multiset_choose(len + q - 1, len);
        if (rank < capacity) return unrank_multiset(rank, len, q);
        rank -= capacity;
    }
    throw std::invalid_argument("rank outside variable capacity");
}

cpp_int decode_variable_multiset(std::vector<int> symbols, int q) {
    int len = symbols.size();
    cpp_int offset = len ? multiset_choose(q + len - 1, len - 1)
                         : cpp_int(0);
    return offset + rank_multiset(std::move(symbols), q);
}

} // namespace communication
