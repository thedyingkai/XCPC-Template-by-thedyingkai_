#pragma once
#include <bits/stdc++.h>
namespace communication {

struct HammingCode {
    enum class Status { Clean, Corrected, DoubleError, Invalid };
    struct Result { Status status; std::vector<int> data; };
    int k, r = 0, n;
    bool extended;

    explicit HammingCode(int data_bits, bool extended = false)
        : k(data_bits), extended(extended) {
        if (k < 0 || k > 1000000)
            throw std::invalid_argument("invalid data length");
        while ((1LL << r) < k + r + 1) ++r;
        n = k + r;
    }

    static bool parity_position(int p) { return (p & (p - 1)) == 0; }

    std::vector<int> encode(const std::vector<int> &data) const {
        if (data.size() != k)
            throw std::invalid_argument("data length mismatch");
        std::vector<int> word(n + extended);
        int syndrome = 0, j = 0;
        for (int p = 1; p <= n; ++p) {
            if (parity_position(p)) continue;
            int bit = data[j++];
            if (bit != 0 && bit != 1)
                throw std::invalid_argument("nonbinary data");
            word[p - 1] = bit;
            if (bit) syndrome ^= p;
        }
        for (int p = 1; p <= n; p *= 2)
            word[p - 1] = bool(syndrome & p);
        if (extended) {
            int parity = 0;
            for (int i = 0; i < n; ++i) parity ^= word[i];
            word[n] = parity;
        }
        return word;
    }

    // 普通码承诺 <=1 错；扩展码承诺 <=2 错时 SECDED。
    Result decode(std::vector<int> word) const {
        if (word.size() != n + extended)
            return {Status::Invalid, {}};
        int syndrome = 0, parity = 0;
        for (int i = 0; i < word.size(); ++i) {
            if (word[i] != 0 && word[i] != 1)
                return {Status::Invalid, {}};
            parity ^= word[i];
            if (i < n && word[i]) syndrome ^= i + 1;
        }
        Status status = Status::Clean;
        if (extended && syndrome && !parity)
            return {Status::DoubleError, {}};
        if (syndrome) {
            if (syndrome > n) return {Status::Invalid, {}};
            word[syndrome - 1] ^= 1;
            status = Status::Corrected;
        } else if (extended && parity) {
            word[n] ^= 1;
            status = Status::Corrected;
        }
        std::vector<int> data;
        for (int p = 1; p <= n; ++p)
            if (!parity_position(p)) data.push_back(word[p - 1]);
        return {status, std::move(data)};
    }
};

} // namespace communication
