#pragma once
#include <bits/stdc++.h>
namespace communication {

template<class Receive>
int receive_minimum_bit(Receive &receive) {
    auto bit = receive(); // 先以有符号类型识别题面错误哨兵。
    if (bit != 0 && bit != 1)
        throw std::runtime_error("invalid protocol bit");
    return int(bit);
}

constexpr std::array<int, 10> minimum_blocks{
    11, 10, 9, 8, 7, 6, 5, 4, 3, 1
};

// send(bit)、receive() 只发送/接收一位，两端按以下顺序执行。
template<class Send, class Receive>
std::uint64_t minimum_alice(
    std::uint64_t a, Send send, Receive receive) {
    int begin = 0;
    std::uint64_t prefix = 0;
    for (int length : minimum_blocks) {
        for (int i = begin; i < begin + length; ++i)
            send(int(a >> (63 - i) & 1));
        int switch_to_b = receive_minimum_bit(receive);
        if (switch_to_b) {
            // earlier blocks 此时均相等；当前块尚未并入 prefix。
            for (int i = begin; i < 64; ++i)
                prefix = (prefix << 1) | receive_minimum_bit(receive);
            return prefix;
        }
        for (int i = begin; i < begin + length; ++i)
            prefix = (prefix << 1) | (a >> (63 - i) & 1);
        begin += length;
    }
    return a;
}

template<class Send, class Receive>
std::uint64_t minimum_bob(
    std::uint64_t b, Send send, Receive receive) {
    int begin = 0, comparison = 0;
    std::uint64_t a = 0;
    for (int length : minimum_blocks) {
        for (int i = begin; i < begin + length; ++i) {
            int bit_a = receive_minimum_bit(receive);
            int bit_b = b >> (63 - i) & 1;
            a = (a << 1) | bit_a;
            if (!comparison && bit_a != bit_b)
                comparison = bit_a < bit_b ? -1 : 1;
        }
        send(comparison > 0);
        if (comparison > 0) {
            for (int i = begin; i < 64; ++i)
                send(int(b >> (63 - i) & 1));
            return b;
        }
        begin += length;
    }
    return a; // comparison<=0，即 A<=B。
}

} // namespace communication
