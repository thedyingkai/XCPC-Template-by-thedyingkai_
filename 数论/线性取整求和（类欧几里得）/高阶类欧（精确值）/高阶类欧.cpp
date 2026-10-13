#include "../../../template/start.cpp"

struct FloorSums {
    i128 sumFloor;
    i128 sumIF;
    i128 sumF2;
};

i128 highFloorDiv(i128 x, i128 y) {
    i128 q = x / y, r = x % y;
    if(r < 0) --q;
    return q;
}

i128 sumIndex(i128 n) {
    return n * (n - 1) / 2;
}

i128 sumI2(i128 n) {
    return n * (n - 1) * (2 * n - 1) / 6;
}

FloorSums floorNonneg(i128 n, i128 m, i128 a, i128 b) {
    if(n == 0) return {0, 0, 0};
    if(a >= m || b >= m) {
        i128 qa = a / m, qb = b / m;
        FloorSums t = floorNonneg(n, m, a % m, b % m);
        i128 s1 = sumIndex(n), s2 = sumI2(n);
        return {
            t.sumFloor + qa * s1 + qb * n,
            t.sumIF + qa * s2 + qb * s1,
            t.sumF2 + qa * qa * s2 + 2 * qa * qb * s1 + qb * qb * n
                + 2 * qa * t.sumIF + 2 * qb * t.sumFloor
        };
    }
    if(a == 0) return {0, 0, 0};
    i128 last = n - 1;
    i128 y = (a * last + b) / m;
    if(y == 0) return {0, 0, 0};
    FloorSums t = floorNonneg(y, a, m, m - b - 1);
    return {
        y * last - t.sumFloor,
        y * last * (last + 1) / 2
            - (t.sumFloor + t.sumF2) / 2,
        last * y * y - 2 * t.sumIF - t.sumFloor
    };
}

// For q_i=floor((a*i+b)/m), i=0..n-1, returns sum q_i,
// sum i*q_i and sum q_i^2. Requires n>=0 and m>0.
FloorSums floorSums(i128 n, i128 m, i128 a, i128 b) {
    i128 qa = highFloorDiv(a, m), qb = highFloorDiv(b, m);
    a -= qa * m;
    b -= qb * m;
    FloorSums t = floorNonneg(n, m, a, b);
    i128 s1 = sumIndex(n), s2 = sumI2(n);
    return {
        t.sumFloor + qa * s1 + qb * n,
        t.sumIF + qa * s2 + qb * s1,
        t.sumF2 + qa * qa * s2 + 2 * qa * qb * s1 + qb * qb * n
            + 2 * qa * t.sumIF + 2 * qb * t.sumFloor
    };
}
