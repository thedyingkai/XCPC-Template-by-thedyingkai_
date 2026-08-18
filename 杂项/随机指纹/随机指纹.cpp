#pragma once

#include "../../template/start.cpp"

struct RandomFingerprint {
    struct Value {
        u64 first = 0, second = 0;
        bool operator==(const Value&) const = default;
        Value& operator+=(const Value& other) {
            first += other.first;
            second += other.second;
            return *this;
        }
        Value& operator-=(const Value& other) {
            first -= other.first;
            second -= other.second;
            return *this;
        }
        Value& operator^=(const Value& other) {
            first ^= other.first;
            second ^= other.second;
            return *this;
        }
    };

    u64 firstSeed, secondSeed;

    static u64 splitmix64(u64 x) {
        x += 0x9e3779b97f4a7c15ULL;
        x = (x ^ (x >> 30)) * 0xbf58476d1ce4e5b9ULL;
        x = (x ^ (x >> 27)) * 0x94d049bb133111ebULL;
        return x ^ (x >> 31);
    }

    static u64 randomSeed() {
        static random_device source;
        u64 value = ((u64) source() << 32) ^ source();
        value ^= (u64) chrono::steady_clock::now().time_since_epoch().count();
        return splitmix64(value);
    }

    RandomFingerprint() : RandomFingerprint(randomSeed(), randomSeed()) {}

    RandomFingerprint(u64 firstSeed_, u64 secondSeed_)
        : firstSeed(firstSeed_), secondSeed(secondSeed_) {}

    Value operator()(i64 label) const {
        u64 value = (u64) label;
        return {splitmix64(value + firstSeed), splitmix64(value + secondSeed)};
    }
};
