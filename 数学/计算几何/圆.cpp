#include "点与直线基础.cpp"

template <class T> struct Circle {
    Point<T> o;
    T r;
    Circle(const Point<T>& o_ = Point<T>(), const T& r_ = 0) : o(o_), r(r_) {}
};

// 0-相离，1-外切，2-相交，3-内切，4-内含，5-重合
template <class T> int circleRelation(const Circle<T>& c1, const Circle<T>& c2) {
    d128 d = distance(c1.o, c2.o), sum = (d128) c1.r + c2.r, dif = fabsl((d128) c1.r - c2.r);
    if(cmp(d) == 0 && cmp(dif) == 0) return 5;
    if(cmp(d - sum) > 0) return 0;
    if(cmp(d - sum) == 0) return 1;
    if(cmp(d - dif) > 0) return 2;
    if(cmp(d - dif) == 0) return 3;
    return 4;
}

template <class T> vector<Point<d128>> lineCircleIntersection(const Line<T>& l, const Circle<T>& c) {
    Point<d128> a = l.a, d = Point<d128>(l.b) - a, o = c.o;
    d128 d2 = dot(d, d), r = c.r;
    if(cmp(d2) == 0) return cmp(square(a - o) - r * r) == 0 ? vector<Point<d128>>{a} : vector<Point<d128>>{};
    d128 t = dot(o - a, d) / d2;
    Point<d128> h = a + d * t;
    d128 x2 = r * r - square(h - o);
    if(cmp(x2) < 0) return {};
    if(cmp(x2) == 0) return {h};
    Point<d128> v = d * sqrtl(max((d128) 0, x2) / d2);
    return {h - v, h + v};
}

template <class T> vector<Point<d128>> circleIntersection(const Circle<T>& c1, const Circle<T>& c2) {
    int rel = circleRelation(c1, c2);
    if(rel == 0 || rel == 4 || rel == 5) return {};
    Point<d128> o1 = c1.o, o2 = c2.o, d = o2 - o1;
    d128 dis = length(d), r1 = c1.r, r2 = c2.r;
    d128 x = (dis * dis + r1 * r1 - r2 * r2) / (2 * dis);
    d128 h2 = max((d128) 0, r1 * r1 - x * x);
    Point<d128> q = o1 + d * (x / dis);
    if(cmp(h2) == 0) return {q};
    Point<d128> v = rotate(d) * (sqrtl(h2) / dis);
    return {q - v, q + v};
}

template <class T> vector<Point<d128>> tangentPoints(const Point<T>& p, const Circle<T>& c) {
    Point<d128> o = c.o, v = Point<d128>(p) - o;
    d128 d2 = square(v), r = c.r;
    if(cmp(d2 - r * r) < 0) return {};
    if(cmp(d2 - r * r) == 0) return {Point<d128>(p)};
    Point<d128> q = o + v * (r * r / d2);
    Point<d128> h = rotate(v) * (r * sqrtl(d2 - r * r) / d2);
    return {q - h, q + h};
}

template <class T> vector<pair<Point<d128>, Point<d128>>> commonTangents(const Circle<T>& c1, const Circle<T>& c2) {
    Point<d128> o1 = c1.o, o2 = c2.o, d = o2 - o1;
    d128 z = square(d), r1 = c1.r, r2 = c2.r;
    vector<pair<Point<d128>, Point<d128>>> ans;
    if(cmp(z) == 0) return ans;
    for(int s : {-1, 1}) {
        d128 r = r1 - s * r2, h2 = z - r * r;
        if(cmp(h2) < 0) continue;
        h2 = max((d128) 0, h2);
        for(int t : {-1, 1}) {
            Point<d128> v = (d * r + rotate(d) * (sqrtl(h2) * t)) / z;
            ans.push_back({o1 + v * r1, o2 + v * (s * r2)});
            if(cmp(h2) == 0) break;
        }
    }
    return ans;
}

template <class T> d128 circleIntersectionArea(const Circle<T>& c1, const Circle<T>& c2) {
    d128 d = distance(c1.o, c2.o), r1 = c1.r, r2 = c2.r;
    if(cmp(d - r1 - r2) >= 0) return 0;
    if(cmp(d - fabsl(r1 - r2)) <= 0) {
        d128 r = min(r1, r2);
        return acosl(-1.0L) * r * r;
    }
    d128 a1 = 2 * acosl(clamp((r1 * r1 + d * d - r2 * r2) / (2 * r1 * d), (d128) -1, (d128) 1));
    d128 a2 = 2 * acosl(clamp((r2 * r2 + d * d - r1 * r1) / (2 * r2 * d), (d128) -1, (d128) 1));
    return (r1 * r1 * (a1 - sinl(a1)) + r2 * r2 * (a2 - sinl(a2))) / 2;
}
