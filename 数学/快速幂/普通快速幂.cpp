#include "../../template/start.cpp"

i64 qp(i64 a, i64 b, i64 p) {
    i64 res = 1 % p;
    a %= p;
    if(a < 0) a += p;
    while(b > 0) {
        if(b & 1) res = (i128) res * a % p;
        a = (i128) a * a % p;
        b >>= 1;
    }
    return res;
}
