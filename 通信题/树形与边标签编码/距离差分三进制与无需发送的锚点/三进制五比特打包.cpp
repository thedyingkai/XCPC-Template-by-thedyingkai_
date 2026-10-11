#pragma once
#include <bits/stdc++.h>
namespace communication {

// 差分 -1,0,1 先映成 digit=delta+1。每三个 digit 用五位编码。
// 位流为低位先发；尾部补零，接收端必须已知原 digit 数。
std::vector<int> pack_ternary(const std::vector<int> &digits) {
    std::vector<int> bits;
    for (int begin = 0; begin < int(digits.size()); begin += 3) {
        int value = 0, power = 1;
        for (int j = 0; j < 3 && begin + j < int(digits.size()); ++j) {
            int d = digits[begin + j];
            if (d < 0 || d > 2)
                throw std::invalid_argument("nonternary digit");
            value += d * power;
            power *= 3;
        }
        for (int bit = 0; bit < 5; ++bit)
            bits.push_back(value >> bit & 1);
    }
    return bits;
}

std::vector<int> unpack_ternary(
    const std::vector<int> &bits, int digit_count) {
    if (digit_count < 0 || int(bits.size()) !=
        5LL * ((digit_count + 2LL) / 3))
        throw std::invalid_argument("bit length mismatch");
    std::vector<int> digits;
    for (int begin = 0; begin < int(bits.size()); begin += 5) {
        int value = 0;
        for (int j = 0; j < 5; ++j) {
            if (bits[begin + j] != 0 && bits[begin + j] != 1)
                throw std::invalid_argument("nonbinary bit");
            value |= bits[begin + j] << j;
        }
        if (value >= 27)
            throw std::invalid_argument("invalid ternary block");
        for (int j = 0; j < 3; ++j) {
            int d = value % 3;
            value /= 3;
            if (int(digits.size()) < digit_count) digits.push_back(d);
            else if (d != 0)
                throw std::invalid_argument("nonzero padding");
        }
    }
    return digits;
}

} // namespace communication
