#pragma once
#include <bits/stdc++.h>
#include <boost/multiprecision/cpp_int.hpp>
namespace communication {

using boost::multiprecision::cpp_int;

cpp_int gray_choose(int n, int k) {
    if (k < 0 || k > n) return 0;
    k = std::min(k, n - k);
    cpp_int result = 1;
    for (int i = 1; i <= k; ++i)
        result = result * (n - k + i) / i;
    return result;
}

// G(n,k) = 0G(n-1,k) + 1 reverse(G(n-1,k-1))。
// reversed 表示列表方向，不是位序反转。
cpp_int rank_weight_gray(std::string_view word) {
    int n = word.size();
    if (word.find_first_not_of("01") != std::string_view::npos)
        throw std::invalid_argument("nonbinary word");
    int k = std::count(word.begin(), word.end(), '1');
    cpp_int total = gray_choose(n, k), rank = 0;
    bool reversed = false;
    for (char bit : word) {
        cpp_int zero_block = total * (n - k) / n;
        cpp_int one_block = total * k / n;
        if (!reversed) {
            if (bit == '0') total = zero_block;
            else { rank += zero_block; total = one_block; }
            reversed = bit == '1';
        } else {
            if (bit == '1') total = one_block;
            else { rank += one_block; total = zero_block; }
            reversed = bit == '0';
        }
        k -= bit == '1';
        --n;
    }
    return rank;
}

std::string unrank_weight_gray(int n, int k, cpp_int rank) {
    if (n < 0 || k < 0 || k > n)
        throw std::invalid_argument("invalid weight parameters");
    cpp_int total = gray_choose(n, k);
    if (rank < 0 || rank >= total)
        throw std::invalid_argument("rank outside Gray list");
    std::string word;
    bool reversed = false;
    while (n) {
        cpp_int zero_block = total * (n - k) / n;
        cpp_int one_block = total * k / n;
        int bit;
        if (!reversed) {
            bit = rank >= zero_block;
            if (bit) { rank -= zero_block; total = one_block; }
            else total = zero_block;
            reversed = bit == 1;
        } else {
            bit = rank < one_block;
            if (bit) total = one_block;
            else { rank -= one_block; total = zero_block; }
            reversed = bit == 0;
        }
        word += char('0' + bit);
        k -= bit;
        --n;
    }
    return word;
}

// 列表大小为偶数时，相邻偶奇排名成对：一次移动一个 1 到一个 0。
std::string fixed_weight_involution(std::string_view word) {
    int n = word.size(), k = std::count(word.begin(), word.end(), '1');
    cpp_int total = gray_choose(n, k);
    if ((total & 1) != 0)
        throw std::invalid_argument("odd state count cannot be paired");
    cpp_int rank = rank_weight_gray(word);
    rank ^= 1;
    return unrank_weight_gray(n, k, rank);
}

} // namespace communication
