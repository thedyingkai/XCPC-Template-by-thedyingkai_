#include <template/start.cpp>

i64 b_mul(i64 a, i64 b, i64 p) {
    u64 c = (u64) a * b - (u64) ((long double) a / p * b + 0.5L) * p;
    return (c + p) % p;
}
