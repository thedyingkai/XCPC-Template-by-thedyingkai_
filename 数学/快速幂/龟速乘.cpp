#include "../../template/start.cpp"

i64 s_mul(i64 a, i64 b, i64 p) {
    i64 res = 0;
    a %= p;
    if(a < 0) a += p;
    auto add_mod = [p](i64 x, i64 y) { return x >= p - y ? x - (p - y) : x + y; };
    for(; b; b >>= 1) {
        if(b & 1) res = add_mod(res, a);
        a = add_mod(a, a);
    }
    return res;
}
