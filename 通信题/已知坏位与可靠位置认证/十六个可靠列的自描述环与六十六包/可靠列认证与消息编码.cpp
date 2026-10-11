#pragma once
#include <bits/stdc++.h>
namespace communication {

using MessagePacket = std::array<int, 31>;

// bad 为固定的 15 个坏列；输出 66 包，外层调用 send_packet。
std::vector<MessagePacket> encode_reliable_columns(
    const std::vector<int> &message, const std::array<bool, 31> &bad) {
    if (message.size() > 1024 ||
        std::count(bad.begin(), bad.end(), true) != 15)
        throw std::invalid_argument("invalid length or bad columns");
    for (int bit : message)
        if (bit != 0 && bit != 1)
            throw std::invalid_argument("nonbinary message");
    std::vector<int> good;
    for (int col = 0; col < 31; ++col)
        if (!bad[col]) good.push_back(col);
    std::vector<int> payload(1024 - message.size(), 0);
    payload.push_back(1);
    payload.insert(payload.end(), message.begin(), message.end());
    std::vector<MessagePacket> packets(66, MessagePacket{});
    int next_bit = 0;
    for (int i = 0; i < 16; ++i) {
        int col = good[i];
        int gap = (good[(i + 1) % 16] - col + 31) % 31;
        packets[gap - 1][col] = 1;
        for (int row = gap; row < 66; ++row)
            packets[row][col] = payload[next_bit++];
    }
    return packets;
}

// received 为实际到达的包；坏列各包内容任意，位置跨包固定。
std::vector<int> decode_reliable_columns(
    const std::vector<MessagePacket> &received) {
    if (received.size() != 66)
        throw std::invalid_argument("expected 66 packets");
    std::array<int, 31> gap{}, successor;
    successor.fill(-1);
    for (int col = 0; col < 31; ++col) {
        for (int row = 0; row < 66; ++row)
            if (received[row][col] != 0 && received[row][col] != 1)
                throw std::invalid_argument("nonbinary packet");
        for (int row = 0; row < 16; ++row)
            if (received[row][col]) {
                gap[col] = row + 1;
                successor[col] = (col + gap[col]) % 31;
                break;
            }
    }
    std::vector<int> good;
    for (int start = 0; start < 31 && good.empty(); ++start) {
        std::array<int, 31> position;
        position.fill(-1);
        std::vector<int> path;
        int u = start;
        while (u != -1 && position[u] == -1) {
            position[u] = path.size();
            path.push_back(u);
            u = successor[u];
        }
        if (u != -1 && int(path.size()) - position[u] == 16)
            good.assign(path.begin() + position[u], path.end());
    }
    if (good.empty())
        throw std::invalid_argument("reliable cycle not found");
    std::sort(good.begin(), good.end());
    std::vector<int> payload;
    for (int col : good)
        for (int row = gap[col]; row < 66; ++row)
            payload.push_back(received[row][col]);
    if (payload.size() != 1025)
        throw std::invalid_argument("invalid cycle headers");
    auto delimiter = std::find(payload.begin(), payload.end(), 1);
    if (delimiter == payload.end())
        throw std::invalid_argument("length delimiter not found");
    return std::vector<int>(delimiter + 1, payload.end());
}

} // namespace communication
