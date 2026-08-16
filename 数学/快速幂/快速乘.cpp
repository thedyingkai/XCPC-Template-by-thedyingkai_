#include "../../template/start.cpp"

i64 b_mul(i64 a, i64 b, i64 p) {
    i64 res = (i128) (a % p) * (b % p) % p;
    if(res < 0) res += p;
    return res;
}
