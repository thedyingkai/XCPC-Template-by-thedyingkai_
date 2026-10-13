#pragma once
#include <bits/stdc++.h>
namespace communication {

// received 长 n-1，原码字属于已知 VT(n, residue) 校验类。
// 恰好删除一位；本函数不负责把任意载荷编码入该类。
std::optional<std::string> decode_vt(
    std::string_view received, int n, int residue) {
    if (n < 1 || received.size() != n - 1 ||
        residue < 0 || residue > n)
        throw std::invalid_argument("invalid VT parameters");
    std::vector<int> suffix(n);
    long long weight = 0;
    for (int i = n - 2; i >= 0; --i) {
        if (received[i] != '0' && received[i] != '1')
            throw std::invalid_argument("nonbinary received word");
        int bit = received[i] - '0';
        suffix[i] = suffix[i + 1] + bit;
        weight = (weight + 1LL * (i + 1) * bit) % (n + 1LL);
    }
    for (int p = 0; p < n; ++p)
        for (int bit = 0; bit <= 1; ++bit)
            if ((weight + 1LL * (p + 1) * bit + suffix[p])
                % (n + 1LL) == residue) {
                std::string word(received);
                word.insert(word.begin() + p, char('0' + bit));
                return word;
            }
    return std::nullopt;
}

} // namespace communication
