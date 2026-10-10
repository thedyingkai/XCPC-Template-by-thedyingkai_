#pragma once

#include "../../圆周方向统计（极角排序与扫描）/合法的整数极角比较器/整数极角.cpp"

// start: exact-intersection
i128 gcdGeom128(i128 a, i128 b) {
    if(a < 0) a = -a;
    if(b < 0) b = -b;
    while(b != 0) {
        i128 r = a % b;
        a = b;
        b = r;
    }
    return a;
}
struct GeomFraction {
    i128 num, den; // den>0，最简分数。
    GeomFraction(i128 n, i128 d) : num(n), den(d) {
        assert(d != 0);
        if(den < 0) num = -num, den = -den;
        i128 g = gcdGeom128(num, den);
        num /= g, den /= g;
    }
};
// 无限直线交点。平行或重合返回 nullopt；输入直线不可退化。
// 分数分子含三次乘积，不能仅按叉积的二次量估计范围。
optional<pair<GeomFraction, GeomFraction>>
exactLineIntersection(const IP& a, const IP& b, const IP& c, const IP& d) {
    assert(a != b && c != d);
    i128 ux = (i128) b.x - a.x, uy = (i128) b.y - a.y;
    i128 vx = (i128) d.x - c.x, vy = (i128) d.y - c.y;
    i128 wx = (i128) c.x - a.x, wy = (i128) c.y - a.y;
    i128 den = ux * vy - uy * vx;
    if(den == 0) return nullopt;
    i128 t = wx * vy - wy * vx;
    return pair{GeomFraction((i128) a.x * den + ux * t, den),
                GeomFraction((i128) a.y * den + uy * t, den)};
}
// end: exact-intersection
