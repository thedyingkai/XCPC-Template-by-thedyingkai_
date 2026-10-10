#pragma once

#include "../../template/start.cpp"

constexpr d128 GEOM_EPS = 1e-12L;
template <class T> int cmp(const T& x) {
    if constexpr(is_floating_point_v<T>) {
        return x > GEOM_EPS ? 1 : (x < -GEOM_EPS ? -1 : 0);
    } else
        return (x > 0) - (x < 0);
}
template <class T> struct Point {
    T x, y;
    Point(const T& x_ = 0, const T& y_ = 0) : x(x_), y(y_) {}
    template <class U> operator Point<U>() const { return Point<U>(U(x), U(y)); }
    Point& operator+=(const Point& p) & {
        x += p.x, y += p.y;
        return *this;
    }
    Point& operator-=(const Point& p) & {
        x -= p.x, y -= p.y;
        return *this;
    }
    Point& operator*=(const T& v) & {
        x *= v, y *= v;
        return *this;
    }
    Point& operator/=(const T& v) & {
        x /= v, y /= v;
        return *this;
    }
    Point operator-() const { return Point(-x, -y); }
    friend Point operator+(Point a, const Point& b) { return a += b; }
    friend Point operator-(Point a, const Point& b) { return a -= b; }
    friend Point operator*(Point a, const T& b) { return a *= b; }
    friend Point operator/(Point a, const T& b) { return a /= b; }
    friend Point operator*(const T& a, Point b) { return b *= a; }
    friend istream& operator>>(istream& is, Point& p) { return is >> p.x >> p.y; }
    friend ostream& operator<<(std::ostream& os, const Point& p) { return os << "(" << p.x << ", " << p.y << ")"; }
};
template <class T, class U> bool operator==(const Point<T>& a, const Point<U>& b) {
    if constexpr(is_integral_v<T> && is_integral_v<U>)
        return a.x == b.x && a.y == b.y;
    else
        return cmp((d128) a.x - b.x) == 0 && cmp((d128) a.y - b.y) == 0;
}
template <class T, class U> bool operator!=(const Point<T>& a, const Point<U>& b) { return !(a == b); }
template <class T> struct Line {
    Point<T> a, b;
    Line(const Point<T>& a_ = Point<T>(), const Point<T>& b_ = Point<T>()) : a(a_), b(b_) {}
};
// 点积
template <class T, class U> auto dot(const Point<T>& a, const Point<U>& b) {
    using R = conditional_t<is_integral_v<T> && is_integral_v<U>, i128, common_type_t<T, U>>;
    return R(a.x) * R(b.x) + R(a.y) * R(b.y);
}
// 叉积
template <class T, class U> auto cross(const Point<T>& a, const Point<U>& b) {
    using R = conditional_t<is_integral_v<T> && is_integral_v<U>, i128, common_type_t<T, U>>;
    return R(a.x) * R(b.y) - R(a.y) * R(b.x);
}
// 向量长度平方
template <class T> auto square(const Point<T>& p) { return dot(p, p); }
// 向量长度
template <class T> d128 length(const Point<T>& p) { return sqrtl((d128) square(p)); }
// 线段长度
template <class T> d128 length(const Line<T>& l) { return length(l.a - l.b); }
// 单位向量
template <class T> Point<d128> normalize(const Point<T>& p) {
    d128 len = length(p);
    assert(cmp(len) != 0);
    return Point<d128>(p.x / len, p.y / len);
}
// 判断平行
template <class T> bool parallel(const Line<T>& l1, const Line<T>& l2) {
    return cmp(cross(l1.b - l1.a, l2.b - l2.a)) == 0;
}
template <class T> d128 distance(const Point<T>& a, const Point<T>& b) { return length(a - b); }
// 点到直线距离
template <class T> d128 distancePL(const Point<T>& p, const Line<T>& l) {
    assert(l.a != l.b);
    return fabsl((d128) cross(l.a - l.b, l.a - p)) / length(l);
}
// 点到线段距离
template <class T> d128 distancePS(const Point<T>& p, const Line<T>& l) {
    if(l.a == l.b) return distance(p, l.a);
    if(cmp(dot(p - l.a, l.b - l.a)) < 0) return distance(p, l.a);
    if(cmp(dot(p - l.b, l.a - l.b)) < 0) return distance(p, l.b);
    return distancePL(p, l);
}
// 逆时针旋转 90°
template <class T> Point<T> rotate(const Point<T>& a) { return Point(-a.y, a.x); }
// 极角排序辅助符号
template <class T> int sgn(const Point<T>& a) { return cmp(a.y) > 0 || (cmp(a.y) == 0 && cmp(a.x) > 0) ? 1 : -1; }
// 点是否在直线左侧
template <class T> bool pointOnLineLeft(const Point<T>& p, const Line<T>& l) {
    return cmp(cross(l.b - l.a, p - l.a)) > 0;
}
// 两直线交点
template <class T> Point<d128> lineIntersection(const Line<T>& l1, const Line<T>& l2) {
    assert(!parallel(l1, l2));
    Point<d128> a = l1.a, b = l1.b, c = l2.a, d = l2.b;
    return a + (b - a) * (cross(d - c, a - c) / cross(d - c, a - b));
}
// 点是否在线段上
template <class T, class U> bool pointOnSegment(const Point<T>& p, const Line<U>& l) {
    if constexpr(is_integral_v<T> && is_integral_v<U>) {
        i128 qx = p.x, qy = p.y, ax = l.a.x, ay = l.a.y, bx = l.b.x, by = l.b.y;
        i128 area = (qx - ax) * (by - ay) - (qy - ay) * (bx - ax);
        return area == 0 && min(ax, bx) <= qx && qx <= max(ax, bx) &&
               min(ay, by) <= qy && qy <= max(ay, by);
    } else {
        Point<d128> q = p, a = l.a, b = l.b;
        return cmp(cross(q - a, b - a)) == 0 && cmp(q.x - min(a.x, b.x)) >= 0 &&
               cmp(q.x - max(a.x, b.x)) <= 0 && cmp(q.y - min(a.y, b.y)) >= 0 &&
               cmp(q.y - max(a.y, b.y)) <= 0;
    }
}
using P = Point<d128>;
