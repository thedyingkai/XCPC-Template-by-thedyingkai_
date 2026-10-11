#pragma once
#include <bits/stdc++.h>
namespace communication {

void check_alphabet(std::string_view alphabet) {
    if (alphabet.size() < 2 || alphabet.size() > 256)
        throw std::invalid_argument("invalid alphabet size");
    std::array<bool, 256> seen{};
    for (unsigned char c : alphabet) {
        if (seen[c]) throw std::invalid_argument("duplicate symbol");
        seen[c] = true;
    }
}

int base_width(std::uint64_t maximum, unsigned q) {
    if (q < 2) throw std::invalid_argument("base must be >= 2");
    unsigned __int128 capacity = 1;
    unsigned __int128 need = (unsigned __int128)maximum + 1;
    int width = 0;
    while (capacity < need) { capacity *= q; ++width; }
    return width;
}

std::string encode_base(std::uint64_t x, int width,
                        std::string_view alphabet) {
    check_alphabet(alphabet);
    if (width < 0) throw std::invalid_argument("negative width");
    std::string s(width, alphabet[0]);
    for (int i = width - 1; i >= 0; --i) {
        s[i] = alphabet[x % alphabet.size()];
        x /= alphabet.size();
    }
    if (x) throw std::overflow_error("value exceeds fixed width");
    return s;
}

std::uint64_t decode_base(std::string_view s,
                          std::string_view alphabet) {
    check_alphabet(alphabet);
    std::array<int, 256> digit;
    digit.fill(-1);
    for (int i = 0; i < int(alphabet.size()); ++i)
        digit[(unsigned char)alphabet[i]] = i;
    std::uint64_t x = 0, q = alphabet.size();
    for (unsigned char c : s) {
        int d = digit[c];
        if (d < 0) throw std::invalid_argument("invalid symbol");
        if (x > (UINT64_MAX - d) / q)
            throw std::overflow_error("uint64 overflow");
        x = x * q + d;
    }
    return x;
}

} // namespace communication
