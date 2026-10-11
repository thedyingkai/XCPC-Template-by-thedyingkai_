#pragma once
#include <bits/stdc++.h>
namespace communication {

// bit 7 为首位，bit 0 为末位；传输的位宽固定为 8。
unsigned reverse_byte(unsigned x) {
    unsigned result = 0;
    for (int i = 0; i < 8; ++i)
        result = (result << 1) | ((x >> i) & 1);
    return result;
}

const std::vector<unsigned> &reversal_representatives() {
    static const auto representatives = [] {
        std::vector<unsigned> result;
        for (unsigned x = 0; x < 256; ++x)
            if (x <= reverse_byte(x)) result.push_back(x);
        return result; // 136 个轨道代表。
    }();
    return representatives;
}

unsigned encode_reversal_orbit(int message) {
    const auto &rep = reversal_representatives();
    if (message < 0 || message >= int(rep.size()))
        throw std::invalid_argument("message outside orbit capacity");
    return rep[message];
}

int decode_reversal_orbit(unsigned received) {
    if (received >= 256)
        throw std::invalid_argument("word must have eight bits");
    unsigned canonical = std::min(received, reverse_byte(received));
    const auto &rep = reversal_representatives();
    return std::lower_bound(rep.begin(), rep.end(), canonical)
         - rep.begin();
}

} // namespace communication
