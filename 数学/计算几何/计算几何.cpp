#include <template/start.cpp>

template <class T> struct Point {
    T x, y;
    Point(const T& x_ = 0, const T& y_ = 0) : x(x_), y(y_) {}
    template <class U> operator Point<U>() { return Point<U>(U(x), U(y)); }
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
    friend bool operator==(const Point& a, const Point& b) { return a.x == b.x && a.y == b.y; }
    friend istream& operator>>(istream& is, Point& p) { return is >> p.x >> p.y; }
    friend ostream& operator<<(std::ostream& os, const Point& p) { return os << "(" << p.x << ", " << p.y << ")"; }
};
template <class T> struct Line {
    Point<T> a, b;
    Line(const Point<T>& a_ = Point<T>(), const Point<T>& b_ = Point<T>()) : a(a_), b(b_) {}
};
// 点积
template <class T> T dot(const Point<T>& a, const Point<T>& b) { return a.x * b.x + a.y * b.y; }
// 叉积
template <class T> T cross(const Point<T>& a, const Point<T>& b) { return a.x * b.y - a.y * b.x; }
// 向量长度平方
template <class T> T square(const Point<T>& p) { return dot(p, p); }
// 向量长度
template <class T> double length(const Point<T>& p) { return sqrt(square(p)); }
// 线段长度
template <class T> double length(const Line<T>& l) { return length(l.a - l.b); }
// 单位向量
template <class T> Point<T> normalize(const Point<T>& p) { return p / length(p); }
// 判断平行
template <class T> bool parallel(const Line<T>& l1, const Line<T>& l2) { return cross(l1.b - l1.a, l2.b - l2.a) == 0; }
template <class T> double distance(const Point<T>& a, const Point<T>& b) { return length(a - b); }
// 点到直线距离
template <class T> double distancePL(const Point<T>& p, const Line<T>& l) {
    return abs(cross(l.a - l.b, l.a - p)) / length(l);
}
// 点到线段距离
template <class T> double distancePS(const Point<T>& p, const Line<T>& l) {
    if(dot(p - l.a, l.b - l.a) < 0) return distance(p, l.a);
    if(dot(p - l.b, l.a - l.b) < 0) return distance(p, l.b);
    return distancePL(p, l);
}
// 逆时针旋转 90°
template <class T> Point<T> rotate(const Point<T>& a) { return Point(-a.y, a.x); }
// 极角排序辅助符号
template <class T> int sgn(const Point<T>& a) { return a.y > 0 || (a.y == 0 && a.x > 0) ? 1 : -1; }
// 点是否在直线左侧
template <class T> bool pointOnLineLeft(const Point<T>& p, const Line<T>& l) { return cross(l.b - l.a, p - l.a) > 0; }
// 两直线交点
template <class T> Point<T> lineIntersection(const Line<T>& l1, const Line<T>& l2) {
    return l1.a + (l1.b - l1.a) * (cross(l2.b - l2.a, l1.a - l2.a) / cross(l2.b - l2.a, l1.a - l1.b));
}
// 点是否在线段上
template <class T> bool pointOnSegment(const Point<T>& p, const Line<T>& l) {
    return cross(p - l.a, l.b - l.a) == 0 && min(l.a.x, l.b.x) <= p.x && p.x <= max(l.a.x, l.b.x) &&
           min(l.a.y, l.b.y) <= p.y && p.y <= max(l.a.y, l.b.y);
}
// 点在多边形内（射线法）
template <class T> bool pointInPolygon(const Point<T>& a, const vector<Point<T>>& p) {
    int n = p.size(), t = 0;
    _rep(i, 0, n) if(pointOnSegment(a, Line(p[i], p[(i + 1) % n]))) return 1;
    _rep(i, 0, n) {
        auto u = p[i], v = p[(i + 1) % n];
        if(u.x < a.x && v.x >= a.x && pointOnLineLeft(a, Line(v, u))) t ^= 1;
        if(u.x >= a.x && v.x < a.x && pointOnLineLeft(a, Line(u, v))) t ^= 1;
    }
    return t == 1;
}
// 线段相交判定（返回类型和交点）
/*0-不相交，1-严格相交，2-重叠，3-在端点处相交*/
template <class T> tuple<int, Point<T>, Point<T>> segmentIntersection(const Line<T>& l1, const Line<T>& l2) {
    if(max(l1.a.x, l1.b.x) < min(l2.a.x, l2.b.x)) return {0, Point<T>(), Point<T>()};
    if(min(l1.a.x, l1.b.x) > max(l2.a.x, l2.b.x)) return {0, Point<T>(), Point<T>()};
    if(max(l1.a.y, l1.b.y) < min(l2.a.y, l2.b.y)) return {0, Point<T>(), Point<T>()};
    if(min(l1.a.y, l1.b.y) > max(l2.a.y, l2.b.y)) return {0, Point<T>(), Point<T>()};
    if(cross(l1.b - l1.a, l2.b - l2.a) == 0) {
        if(cross(l1.b - l1.a, l2.a - l1.a) != 0)
            return {0, Point<T>(), Point<T>()};
        else {
            auto maxx1 = max(l1.a.x, l1.b.x), minx1 = min(l1.a.x, l1.b.x), maxy1 = max(l1.a.y, l1.b.y),
                 miny1 = min(l1.a.y, l1.b.y), maxx2 = max(l2.a.x, l2.b.x), minx2 = min(l2.a.x, l2.b.x),
                 maxy2 = max(l2.a.y, l2.b.y), miny2 = min(l2.a.y, l2.b.y);
            Point<T> p1(smax(minx1, minx2), max(miny1, miny2)), p2(min(maxx1, maxx2), min(maxy1, maxy2));
            if(!pointOnSegment(p1, l1)) swap(p1.y, p2.y);
            if(p1 == p2)
                return {3, p1, p2};
            else
                return {2, p1, p2};
        }
    }
    auto cp1 = cross(l2.a - l1.a, l2.b - l1.a), cp2 = cross(l2.a - l1.b, l2.b - l1.b),
         cp3 = cross(l1.a - l2.a, l1.b - l2.a), cp4 = cross(l1.a - l2.b, l1.b - l2.b);
    if((cp1 > 0 && cp2 > 0) || (cp1 < 0 && cp2 < 0) || (cp3 > 0 && cp4 > 0) || (cp3 < 0 && cp4 < 0))
        return {0, Point<T>(), Point<T>()};
    Point p = lineIntersection(l1, l2);
    if(cp1 != 0 && cp2 != 0 && cp3 != 0 && cp4 != 0)
        return {1, p, p};
    else
        return {3, p, p};
}
// 线段到线段最短距离
template <class T> double distanceSS(const Line<T>& l1, const Line<T>& l2) {
    if(get<0>(segmentIntersection(l1, l2)) != 0) return 0.0;
    return min({distancePS(l1.a, l2), distancePS(l1.b, l2), distancePS(l2.a, l1), distancePS(l2.b, l1)});
}
// 线段是否在多边形内部
template <class T> bool segmentInPolygon(const Line<T>& l, const std::vector<Point<T>>& p) {
    int n = p.size();
    if(!pointInPolygon(l.a, p)) return 0;
    if(!pointInPolygon(l.b, p)) return 0;
    _rep(i, 0, n) {
        auto u = p[i], v = p[(i + 1) % n], w = p[(i + 2) % n];
        auto [t, p1, p2] = segmentIntersection(l, Line(u, v));
        if(t == 1) return 0;
        if(t == 0) continue;
        if(t == 2) {
            if(pointOnSegment(v, l) && v != l.a && v != l.b)
                if(cross(v - u, w - v) > 0) return 0;
        } else {
            if(p1 != u && p1 != v) {
                if(pointOnLineLeft(l.a, Line(v, u)) || pointOnLineLeft(l.b, Line(v, u))) return 0;
            } else if(p1 == v) {
                if(l.a == v) {
                    if(pointOnLineLeft(u, l)) {
                        if(pointOnLineLeft(w, l) && pointOnLineLeft(w, Line(u, v))) return 0;
                    } else if(pointOnLineLeft(w, l) || pointOnLineLeft(w, Line(u, v)))
                        return 0;
                } else if(l.b == v) {
                    if(pointOnLineLeft(u, Line(l.b, l.a))) {
                        if(pointOnLineLeft(w, Line(l.b, l.a)) && pointOnLineLeft(w, Line(u, v))) return 0;
                    } else if(pointOnLineLeft(w, Line(l.b, l.a)) || pointOnLineLeft(w, Line(u, v)))
                        return 0;
                } else {
                    if(pointOnLineLeft(u, l)) {
                        if(pointOnLineLeft(w, Line(l.b, l.a)) || pointOnLineLeft(w, Line(u, v))) return 0;
                    } else if(pointOnLineLeft(w, l) || pointOnLineLeft(w, Line(u, v)))
                        return 0;
                }
            }
        }
    }
    return 1;
}
// 半平面交（返回交点多边形）
template <class T> vector<Point<T>> hp(vector<Line<T>> lines) {
    sort(lines.begin(), lines.end(), [&](auto l1, auto l2) {
        auto d1 = l1.b - l1.a, d2 = l2.b - l2.a;
        if(sgn(d1) != sgn(d2)) return sgn(d1) == 1;
        return cross(d1, d2) > 0;
    });
    deque<Line<T>> ls;
    deque<Point<T>> ps;
    for(auto l : lines) {
        if(ls.empty()) {
            ls.push_back(l);
            continue;
        }
        while(!ps.empty() && !pointOnLineLeft(ps.back(), l)) ps.pop_back(), ls.pop_back();
        while(!ps.empty() && !pointOnLineLeft(ps[0], l)) ps.pop_front(), ls.pop_front();
        if(cross(l.b - l.a, ls.back().b - ls.back().a) == 0) {
            if(dot(l.b - l.a, ls.back().b - ls.back().a) > 0) {
                if(!pointOnLineLeft(ls.back().a, l)) assert(ls.size() == 1), ls[0] = l;
                continue;
            }
            return {};
        }
        ps.push_back(lineIntersection(ls.back(), l)), ls.push_back(l);
    }
    while(!ps.empty() && !pointOnLineLeft(ps.back(), ls[0])) ps.pop_back(), ls.pop_back();
    if(ls.size() <= 2) return {};
    ps.push_back(lineIntersection(ls[0], ls.back()));
    return vector(ps.begin(), ps.end());
}
using P = Point<d128>;
constexpr d128 eps = 0;
