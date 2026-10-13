#pragma once
#include <bits/stdc++.h>
namespace communication {

std::string encode_marker(std::string binary) {
    if (binary.empty() || binary.find_first_not_of("01") !=
                          std::string::npos)
        throw std::invalid_argument("need nonempty binary word");
    auto first = binary.find('1');
    if (first != std::string::npos)
        std::fill(binary.begin(), binary.begin() + first + 1, '2');
    return binary;
}

std::string decode_marker(std::string_view received) {
    int n = received.size();
    if (!n || received.find_first_not_of("012") !=
              std::string_view::npos)
        throw std::invalid_argument("invalid received word");
    if (received.find_first_not_of('0') == std::string_view::npos)
        return std::string(n, '0');
    if (received.find_first_not_of('2') == std::string_view::npos)
        return std::string(n - 1, '0') + '1';
    int start = -1;
    for (int i = 0; i < n; ++i)
        if (received[i] == '2' && received[(i + n - 1) % n] != '2') {
            if (start != -1)
                throw std::invalid_argument("multiple marker runs");
            start = i;
        }
    if (start == -1) throw std::invalid_argument("missing marker");
    std::string word;
    for (int i = 0; i < n; ++i) word += received[(start + i) % n];
    int length = word.find_first_not_of('2');
    if (word.find('2', length) != std::string::npos)
        throw std::invalid_argument("broken marker run");
    std::fill(word.begin(), word.begin() + length - 1, '0');
    word[length - 1] = '1';
    return word;
}

} // namespace communication
