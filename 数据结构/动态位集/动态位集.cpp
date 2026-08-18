#pragma once

#include "../../template/start.cpp"

struct DynamicBitset {
    int size = 0;
    vector<u64> word;

    explicit DynamicBitset(int size_ = 0) : size(size_), word((size + 63) >> 6) {}

    void clear() { fill(word.begin(), word.end(), 0); }
    void set(int position) {
        assert(0 <= position && position < size);
        word[position >> 6] |= 1ULL << (position & 63);
    }
    bool test(int position) const {
        assert(0 <= position && position < size);
        return word[position >> 6] >> (position & 63) & 1ULL;
    }

    void shiftOr(int shift) {
        assert(shift >= 0);
        if(shift == 0 || shift >= size) return;
        int whole = shift >> 6, part = shift & 63;
        for(int i = (int) word.size() - 1; i >= whole; i--) {
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
