#pragma once

#include "../../凸包极值与点定位（旋转卡壳）/凸包与旋转卡壳.cpp"

// start: integer-polar
using IP = Point<i64>;

// 先提升再相减；仍须保证最终行列式装入 i128。
i128 orient128(const IP& a, const IP& b, const IP& c) {
    i128 x1 = (i128) b.x - a.x, y1 = (i128) b.y - a.y;
    i128 x2 = (i128) c.x - a.x, y2 = (i128) c.y - a.y;
    return x1 * y2 - y1 * x2;
}
bool zeroVector(const IP& p) { return p.x == 0 && p.y == 0; }
int polarHalf(const IP& p) { return p.y < 0 || (p.y == 0 && p.x < 0); }
struct PolarLess {
    bool operator()(const IP& a, const IP& b) const {
        int x = polarHalf(a), y = polarHalf(b);
        if(x != y) return x < y;
        return cross(a, b) > 0;
    }
};
// 只接收非零向量；用半平面区分同向和反向。
bool sameRay(const IP& a, const IP& b) {
    return !zeroVector(a) && !zeroVector(b) && polarHalf(a) == polarHalf(b) && cross(a, b) == 0;
}
// end: integer-polar
