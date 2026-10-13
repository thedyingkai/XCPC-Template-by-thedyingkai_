#pragma once
#include <bits/stdc++.h>
namespace communication {

int prime(int m) {
    if (m < 2 || m > INT_MAX / 6)
        throw std::invalid_argument("invalid color count");
    auto prime = [](int x) {
        if (x < 2) return false;
        for (int d = 2; 1LL * d * d <= x; ++d)
            if (x % d == 0) return false;
        return true;
    };
    int p = m;
    while (!prime(p)) ++p;
    return p;
}

// 消息为 1..m，颜色为 1..m；每种颜色恰好出现三次。
std::vector<int> encode_shift(int m, int message) {
    int p = prime(m);
    if (message < 1 || message > m)
        throw std::invalid_argument("message outside domain");
    std::vector<int> base, result, count(m + 1);
    for (int color = 1; color <= m; ++color) {
        result.push_back(color);
        ++count[color];
        base.push_back(color);
    }
    for (int color = 1; color <= p - m; ++color)
        base.push_back(color);
    int shift = message - 1;
    for (int i = 0; i < p; ++i) {
        int color = base[(i + shift) % p];
        result.push_back(color);
        ++count[color];
    }
    for (int color = 1; color <= m; ++color)
        while (count[color] < 3) {
            result.push_back(color);
            ++count[color];
        }
    return result;
}

int decode_shift(int m, const std::vector<int> &bits) {
    int p = prime(m);
    if (bits.size() != 3 * m)
        throw std::invalid_argument("received length mismatch");
    for (int bit : bits)
        if (bit != 0 && bit != 1)
            throw std::invalid_argument("nonbinary received word");
    long long ones = 0, wb = 0, wc = 0;
    for (int i = 0; i < p; ++i) {
        int color_index = i < m ? i : i - m;
        int bit = bits[color_index];
        ones += bit;
        wb = (wb + 1LL * i * bit) % p;
        wc = (wc + 1LL * i * bits[m + i]) % p;
    }
    if (ones == 0 || ones == p)
        throw std::invalid_argument("constant color mapping");
    long long inverse = 1, a = ones;
    for (int e = p - 2; e; e >>= 1, a = a * a % p)
        if (e & 1) inverse = inverse * a % p;
    long long shift = ((wb - wc + p) % p) * inverse % p;
    if (shift >= m)
        throw std::invalid_argument("shift outside message domain");
    return int(shift) + 1;
}

} // namespace communication
