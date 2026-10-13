#pragma once

#include "../../template/start.cpp"

struct DynamicBitset {
    int size = 0;
    vector<u64> word;

    explicit DynamicBitset(int size_ = 0) : size(size_), word((size + 63) >> 6) {}

    void clear() { fill(word.begin(), word.end(), 0); }
    void set(int position) {
        word[position >> 6] |= 1ULL << (position & 63);
    }
    bool test(int position) const {
        return word[position >> 6] >> (position & 63) & 1ULL;
    }
    DynamicBitset& operator|=(const DynamicBitset& other) {
        for(int i = 0; i < word.size(); i++) word[i] |= other.word[i];
        return *this;
    }

    void shiftOr(int shift) {
        if(shift == 0 || shift >= size) return;
        int whole = shift >> 6, part = shift & 63;
        for(int i = word.size(); i-- > whole;) {
            u64 value = word[i - whole] << part;
            if(part && i - whole - 1 >= 0) value |= word[i - whole - 1] >> (64 - part);
            word[i] |= value;
        }
        if(size & 63) word.back() &= (1ULL << (size & 63)) - 1;
    }

    int count() const {
        int result = 0;
        for(u64 value : word) result += popcount(value);
        return result;
    }
};
