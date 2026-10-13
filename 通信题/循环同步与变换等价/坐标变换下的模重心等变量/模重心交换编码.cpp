#pragma once
#include <bits/stdc++.h>
namespace communication {

long long centroid_inv(long long a, long long mod) {
    long long b = mod, x = 1, y = 0;
    while (b) {
        long long q = a / b;
        long long next_a = a - q * b, next_x = x - q * y;
        a = b; b = next_a;
        x = y; y = next_x;
    }
    if (a != 1) throw std::invalid_argument("weight is not invertible");
    return (x % mod + mod) % mod;
}

// 返回 (黑格数, 行坐标和 mod n, 列坐标和 mod n)。
std::array<long long, 3> centroid_info(
    const std::vector<std::string> &picture) {
    int n = picture.size();
    if (n < 2) throw std::invalid_argument("need n >= 2");
    long long weight = 0, row_sum = 0, col_sum = 0;
    for (int r = 0; r < n; ++r) {
        if (picture[r].size() != n)
            throw std::invalid_argument("picture must be square");
        for (int c = 0; c < n; ++c) {
            char cell = picture[r][c];
            if (cell != '#' && cell != '.')
                throw std::invalid_argument("invalid picture symbol");
            if (cell == '#') {
                ++weight;
                row_sum = (row_sum + r) % n;
                col_sum = (col_sum + c) % n;
            }
        }
    }
    if (std::gcd(weight, (long long)n) != 1)
        throw std::invalid_argument("weight must be coprime to n");
    return {weight, row_sum, col_sum};
}

// 返回两个待交换格的 (r1,c1,r2,c2)，均为 0-based。
std::array<int, 4> encode_centroid(
    const std::vector<std::string> &picture, int target_r, int target_c) {
    int n = picture.size();
    auto [weight, row_sum, col_sum] = centroid_info(picture);
    if (target_r < 0 || target_r >= n || target_c < 0 || target_c >= n)
        throw std::invalid_argument("target outside picture");
    int dr = ((weight % n) * target_r - row_sum + n) % n;
    int dc = ((weight % n) * target_c - col_sum + n) % n;
    if (!dr && !dc) return {0, 0, 0, 0};
    for (int r = 0; r < n; ++r)
        for (int c = 0; c < n; ++c)
            if (picture[r][c] == '#') {
                int qr = (r + dr) % n, qc = (c + dc) % n;
                if (picture[qr][qc] == '.') return {r, c, qr, qc};
            }
    throw std::logic_error("coprime orbit argument violated");
}

std::pair<int, int> decode_centroid(
    const std::vector<std::string> &picture) {
    int n = picture.size();
    auto [weight, row_sum, col_sum] = centroid_info(picture);
    long long inverse = centroid_inv(weight % n, n);
    return {int(row_sum * inverse % n), int(col_sum * inverse % n)};
}

} // namespace communication
