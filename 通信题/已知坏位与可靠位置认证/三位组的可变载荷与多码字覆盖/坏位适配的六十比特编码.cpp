#pragma once
#include <bits/stdc++.h>
namespace communication {

const std::array<std::string, 8> &broken_triplet_table() {
    static const std::array<std::string, 8> table{
        "", "1", "0", "10", "00", "01", "1", "11"
    };
    return table; // 码字按三位二进制数编号，首位为最高位。
}

// 150 位，至多 40 位坏且强制为 0；消息低位先传，共 60 位。
std::vector<int> encode_broken60(
    std::uint64_t message, const std::array<bool, 150> &bad) {
    if (message >> 60 ||
        std::count(bad.begin(), bad.end(), true) > 40)
        throw std::invalid_argument("invalid message or bad mask");
    const auto &table = broken_triplet_table();
    std::vector<int> word(150);
    int position = 0;
    for (int group = 0; group < 50; ++group) {
        int bad_mask = 0;
        for (int j = 0; j < 3; ++j)
            if (bad[3 * group + j]) bad_mask |= 1 << (2 - j);
        int best = 0;
        if (position < 60)
            for (int code = 0; code < 8; ++code) {
                if (code & bad_mask) continue;
                bool matches = true;
                for (int j = 0; j < int(table[code].size()); ++j) {
                    int bit = position + j < 60
                            ? int(message >> (position + j) & 1)
                            : 0; // 最后一组的额外载荷补零。
                    if (table[code][j] - '0' != bit) matches = false;
                }
                if (matches && table[code].size() > table[best].size())
                    best = code;
            }
        for (int j = 0; j < 3; ++j)
            word[3 * group + j] = best >> (2 - j) & 1;
        position += table[best].size();
    }
    if (position < 60)
        throw std::logic_error("insufficient proven capacity");
    return word;
}

std::uint64_t decode_broken60(const std::vector<int> &word) {
    if (word.size() != 150)
        throw std::invalid_argument("word length must be 150");
    std::string payload;
    for (int group = 0; group < 50; ++group) {
        int code = 0;
        for (int j = 0; j < 3; ++j) {
            int bit = word[3 * group + j];
            if (bit != 0 && bit != 1)
                throw std::invalid_argument("nonbinary received word");
            code = (code << 1) | bit;
        }
        payload += broken_triplet_table()[code];
    }
    if (payload.size() < 60)
        throw std::invalid_argument("payload shorter than sixty bits");
    std::uint64_t message = 0;
    for (int i = 0; i < 60; ++i)
        if (payload[i] == '1') message |= std::uint64_t(1) << i;
    return message;
}

} // namespace communication
