#pragma once
#include <bits/stdc++.h>
namespace communication {

int line_mod31(int x) { x %= 31; return x < 0 ? x + 31 : x; }

int line_inverse31(int x) {
    x = line_mod31(x);
    if (!x) throw std::invalid_argument("duplicate x coordinate");
    int result = 1;
    for (int e = 29; e; e >>= 1, x = x * x % 31)
        if (e & 1) result = result * x % 31;
    return result;
}

// 0-based 消息编号 0..599；发送 30 个互异包，包值 1..930。
std::vector<int> encode_two_packet_line(int message) {
    if (message < 0 || message >= 600)
        throw std::invalid_argument("message outside domain");
    int a = message / 31, b = message % 31;
    std::vector<int> packets;
    for (int x = 0; x < 30; ++x)
        packets.push_back(31 * x + (a * x + b) % 31 + 1);
    return packets;
}

int decode_two_packet_line(int first, int second) {
    if (first < 1 || first > 930 || second < 1 || second > 930)
        throw std::invalid_argument("invalid packet");
    int x1 = (first - 1) / 31, y1 = (first - 1) % 31;
    int x2 = (second - 1) / 31, y2 = (second - 1) % 31;
    int a = line_mod31((y2 - y1) * line_inverse31(x2 - x1));
    int b = line_mod31(y1 - a * x1);
    int message = a * 31 + b;
    if (message >= 600)
        throw std::invalid_argument("packets encode no valid message");
    return message;
}

} // namespace communication
