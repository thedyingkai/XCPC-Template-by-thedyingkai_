#include <template/start.cpp>

i64 s_mul(i64 a, i64 b, i64 p) {
    int res = 0;
    a %= p;
    for(; b; b >>= 1) {
        if(b & 1) res = (res + a) % p;
        a = (a + a) % p;
    }
    return res % p;
}
