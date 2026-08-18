#include "../../template/start.cpp"

i128 floorDiv(i128 x, i128 y) {
    assert(y > 0);
    i128 q = x / y, r = x % y;
    if(r < 0) --q;
    return q;
}

// sum_{i=0}^{n-1} floor((a*i+b)/m), n>=0, m>0.
i128 floorSum(i128 n, i128 m, i128 a, i128 b) {
    assert(n >= 0 && m > 0);
    i128 qa = floorDiv(a, m), qb = floorDiv(b, m);
    a -= qa * m;
    b -= qb * m;
    i128 ans = qa * n * (n - 1) / 2 + qb * n;
    while(true) {
        if(a >= m) {
            ans += (a / m) * n * (n - 1) / 2;
            a %= m;
        }
        if(b >= m) {
            ans += (b / m) * n;
            b %= m;
        }
        i128 y = a * n + b;
        if(y < m) break;
        n = y / m;
        b = y % m;
        swap(a, m);
    }
    return ans;
}
