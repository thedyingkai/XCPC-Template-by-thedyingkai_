#pragma once

#include "../../template/start.cpp"

struct FloorSumsMod {
    i64 sumFloor;
    i64 sumIndexFloor;
    i64 sumFloorSquare;
};

struct HighFloorSumsModSolver {
    i64 mod, inv2;

    explicit HighFloorSumsModSolver(i64 oddMod) : mod(oddMod) {
        assert(mod > 0 && (mod & 1));
        inv2 = (i64)(((i128)mod + 1) / 2 % mod);
    }

    i64 norm(i128 x) const {
        x %= mod;
        if(x < 0) x += mod;
        return (i64)x;
    }

    i64 add(i64 a, i64 b) const {
        return norm((i128)a + b);
    }

    i64 sub(i64 a, i64 b) const {
        return norm((i128)a - b);
    }

    i64 mul(i64 a, i64 b) const {
        return (i64)((i128)a * b % mod);
    }

    static i128 floorDiv(i128 x, i128 y) {
        assert(y > 0);
        i128 q = x / y, r = x % y;
        if(r < 0) --q;
        return q;
    }

    // sum_{i=0}^{n-1} i modulo mod. Reducing n modulo 2*mod
    // lets the exact division by 2 work for every odd modulus.
    i64 sumIndex(i128 n) const {
        assert(n >= 0);
        i128 x = n % ((i128)2 * mod);
        i128 a = x, b = x - 1;
        if(a % 2 == 0) a /= 2;
        else b /= 2;
        return mul(norm(a), norm(b));
    }

    // sum_{i=0}^{n-1} i^2 modulo mod. Cancel 2 and 3 in
    // n*(n-1)*(2*n-1)/6 before taking residues; mod need not be prime.
    i64 sumIndexSquare(i128 n) const {
        assert(n >= 0);
        i128 x = n % ((i128)6 * mod);
        array<i128, 3> factor = {x, x - 1, 2 * x - 1};
        for(i128 divisor : {2, 3}) {
            for(i128& value : factor) {
                if(value % divisor == 0) {
                    value /= divisor;
                    break;
                }
            }
        }
        i64 result = 1 % mod;
        for(i128 value : factor) result = mul(result, norm(value));
        return result;
    }

    // If q_i = base_i + qa*i + qb, update the three required sums.
    FloorSumsMod addAffine(FloorSumsMod base, i128 n, i128 qa, i128 qb) const {
        i64 a = norm(qa), b = norm(qb), twoA = add(a, a), twoB = add(b, b);
        i64 count = norm(n), s1 = sumIndex(n), s2 = sumIndexSquare(n);
        FloorSumsMod result;
        result.sumFloor = add(base.sumFloor, add(mul(a, s1), mul(b, count)));
        result.sumIndexFloor = add(base.sumIndexFloor, add(mul(a, s2), mul(b, s1)));
        result.sumFloorSquare = base.sumFloorSquare;
        result.sumFloorSquare = add(result.sumFloorSquare, mul(mul(a, a), s2));
        result.sumFloorSquare = add(result.sumFloorSquare, mul(mul(twoA, b), s1));
        result.sumFloorSquare = add(result.sumFloorSquare, mul(mul(b, b), count));
        result.sumFloorSquare = add(result.sumFloorSquare, mul(twoA, base.sumIndexFloor));
        result.sumFloorSquare = add(result.sumFloorSquare, mul(twoB, base.sumFloor));
        return result;
    }

    FloorSumsMod nonnegative(i128 n, i128 m, i128 a, i128 b) const {
        if(n == 0) return {0, 0, 0};
        if(a >= m || b >= m) {
            i128 qa = a / m, qb = b / m;
            return addAffine(nonnegative(n, m, a % m, b % m), n, qa, qb);
        }
        if(a == 0) return {0, 0, 0};
        i128 last = n - 1;
        i128 y = (a * last + b) / m;
        if(y == 0) return {0, 0, 0};
        FloorSumsMod t = nonnegative(y, a, m, m - b - 1);
        i64 ym = norm(y), lastm = norm(last);
        FloorSumsMod result;
        result.sumFloor = sub(mul(ym, lastm), t.sumFloor);
        i64 half = mul(add(t.sumFloor, t.sumFloorSquare), inv2);
        result.sumIndexFloor = sub(mul(ym, sumIndex(last + 1)), half);
        result.sumFloorSquare = sub(
            sub(mul(lastm, mul(ym, ym)), add(t.sumIndexFloor, t.sumIndexFloor)),
            t.sumFloor
        );
        return result;
    }

    FloorSumsMod solve(i64 n, i64 m, i64 a, i64 b) const {
        assert(n >= 0 && m > 0);
        i128 qa = floorDiv(a, m), qb = floorDiv(b, m);
        i128 reducedA = (i128)a - qa * m;
        i128 reducedB = (i128)b - qb * m;
        return addAffine(nonnegative(n, m, reducedA, reducedB), n, qa, qb);
    }
};

// For q_i=floor((a*i+b)/m), i=0..n-1, returns sum q_i,
// sum i*q_i and sum q_i^2 modulo oddMod.
FloorSumsMod highFloorSumsMod(i64 n, i64 m, i64 a, i64 b, i64 oddMod) {
    return HighFloorSumsModSolver(oddMod).solve(n, m, a, b);
}
