#ifndef XCPC_GEOMETRY_SEGMENT_POLYGON
#define XCPC_GEOMETRY_SEGMENT_POLYGON

#include "点与直线基础.cpp"

// 点在多边形内（射线法）
template <class T> bool pointInPolygon(const Point<T>& a, const vector<Point<T>>& p) {
    int n = p.size(), t = 0;
    _rep(i, 0, n) if(pointOnSegment(a, Line(p[i], p[(i + 1) % n]))) return 1;
    _rep(i, 0, n) {
        auto u = p[i], v = p[(i + 1) % n];
        if(cmp(u.x - a.x) < 0 && cmp(v.x - a.x) >= 0 && pointOnLineLeft(a, Line(v, u))) t ^= 1;
        if(cmp(u.x - a.x) >= 0 && cmp(v.x - a.x) < 0 && pointOnLineLeft(a, Line(u, v))) t ^= 1;
    }
    return t == 1;
}
// 线段相交判定（返回类型和交点）
/*0-不相交，1-严格相交，2-重叠，3-在端点处相交*/
template <class T> tuple<int, Point<d128>, Point<d128>> segmentIntersection(const Line<T>& l1, const Line<T>& l2) {
    using P = Point<d128>;
    if(cmp(max(l1.a.x, l1.b.x) - min(l2.a.x, l2.b.x)) < 0) return {0, P(), P()};
    if(cmp(min(l1.a.x, l1.b.x) - max(l2.a.x, l2.b.x)) > 0) return {0, P(), P()};
    if(cmp(max(l1.a.y, l1.b.y) - min(l2.a.y, l2.b.y)) < 0) return {0, P(), P()};
    if(cmp(min(l1.a.y, l1.b.y) - max(l2.a.y, l2.b.y)) > 0) return {0, P(), P()};
    if(cmp(cross(l1.b - l1.a, l2.b - l2.a)) == 0) {
        if(cmp(cross(l1.b - l1.a, l2.a - l1.a)) != 0)
            return {0, P(), P()};
        else {
            auto maxx1 = max(l1.a.x, l1.b.x), minx1 = min(l1.a.x, l1.b.x), maxy1 = max(l1.a.y, l1.b.y),
                 miny1 = min(l1.a.y, l1.b.y), maxx2 = max(l2.a.x, l2.b.x), minx2 = min(l2.a.x, l2.b.x),
                 maxy2 = max(l2.a.y, l2.b.y), miny2 = min(l2.a.y, l2.b.y);
            P p1(max(minx1, minx2), max(miny1, miny2)), p2(min(maxx1, maxx2), min(maxy1, maxy2));
            if(!pointOnSegment(p1, l1)) swap(p1.y, p2.y);
            if(p1 == p2)
                return {3, p1, p2};
            else
                return {2, p1, p2};
        }
    }
    auto cp1 = cross(l2.a - l1.a, l2.b - l1.a), cp2 = cross(l2.a - l1.b, l2.b - l1.b),
         cp3 = cross(l1.a - l2.a, l1.b - l2.a), cp4 = cross(l1.a - l2.b, l1.b - l2.b);
    if((cmp(cp1) > 0 && cmp(cp2) > 0) || (cmp(cp1) < 0 && cmp(cp2) < 0) ||
       (cmp(cp3) > 0 && cmp(cp4) > 0) || (cmp(cp3) < 0 && cmp(cp4) < 0))
        return {0, P(), P()};
    P p = lineIntersection(l1, l2);
    if(cmp(cp1) != 0 && cmp(cp2) != 0 && cmp(cp3) != 0 && cmp(cp4) != 0)
        return {1, p, p};
    else
        return {3, p, p};
}
// 线段到线段最短距离
template <class T> d128 distanceSS(const Line<T>& l1, const Line<T>& l2) {
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
                if(cmp(cross(v - u, w - v)) > 0) return 0;
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

#endif
