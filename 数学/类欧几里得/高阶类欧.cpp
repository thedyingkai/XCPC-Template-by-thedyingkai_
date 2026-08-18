#include "../../template/start.cpp"

struct FloorSums {
    i128 sumFloor;
    i128 sumIndexFloor;
    i128 sumFloorSquare;
};

i128 highFloorDiv(i128 x, i128 y) {
    assert(y > 0);
    i128 q = x / y, r = x % y;
    if(r < 0) --q;
    return q;
}

i128 sumIndex(i128 n) {
    return n * (n - 1) / 2;
}

i128 sumIndexSquare(i128 n) {
    return n * (n - 1) * (2 * n - 1) / 6;
}

FloorSums highFloorNonnegative(i128 n, i128 m, i128 a, i128 b) {
    if(n == 0) return {0, 0, 0};
    if(a >= m || b >= m) {
        i128 qa = a / m, qb = b / m;
        FloorSums t = highFloorNonnegative(n, m, a % m, b % m);
        i128 s1 = sumIndex(n), s2 = sumIndexSquare(n);
        return {
            t.sumFloor + qa * s1 + qb * n,
            t.sumIndexFloor + qa * s2 + qb * s1,
            t.sumFloorSquare + qa * qa * s2 + 2 * qa * qb * s1 + qb * qb * n
                + 2 * qa * t.sumIndexFloor + 2 * qb * t.sumFloor
        };
    }
    if(a == 0) return {0, 0, 0};
    i128 last = n - 1;
    i128 y = (a * last + b) / m;
    if(y == 0) return {0, 0, 0};
    FloorSums t = highFloorNonnegative(y, a, m, m - b - 1);
    return {
        y * last - t.sumFloor,
        y * last * (last + 1) / 2
            - (t.sumFloor + t.sumFloorSquare) / 2,
        last * y * y - 2 * t.sumIndexFloor - t.sumFloor
    };
}

// For q_i=floor((a*i+b)/m), i=0..n-1, returns sum q_i,
// sum i*q_i and sum q_i^2. Requires n>=0 and m>0.
FloorSums highFloorSums(i128 n, i128 m, i128 a, i128 b) {
    assert(n >= 0 && m > 0);
    i128 qa = highFloorDiv(a, m), qb = highFloorDiv(b, m);
    a -= qa * m;
    b -= qb * m;
    FloorSums t = highFloorNonnegative(n, m, a, b);
    i128 s1 = sumIndex(n), s2 = sumIndexSquare(n);
    return {
        t.sumFloor + qa * s1 + qb * n,
        t.sumIndexFloor + qa * s2 + qb * s1,
        t.sumFloorSquare + qa * qa * s2 + 2 * qa * qb * s1 + qb * qb * n
            + 2 * qa * t.sumIndexFloor + 2 * qb * t.sumFloor
    };
}
