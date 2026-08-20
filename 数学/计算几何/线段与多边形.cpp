#pragma once

#include "点与直线基础.cpp"

// start: point-in-polygon
// 点在多边形内（射线法）
template <class T> bool pointInPolygon(const Point<T>& a, const vector<Point<T>>& p) {
    int n = p.size(), t = 0;
    for(int i = 0; i < n; i++)
        if(pointOnSegment(a, Line(p[i], p[(i + 1) % n]))) return 1;
    for(int i = 0; i < n; i++) {
        auto u = p[i], v = p[(i + 1) % n];
        if(cmp(u.x - a.x) < 0 && cmp(v.x - a.x) >= 0 && pointOnLineLeft(a, Line(v, u))) t ^= 1;
        if(cmp(u.x - a.x) >= 0 && cmp(v.x - a.x) < 0 && pointOnLineLeft(a, Line(u, v))) t ^= 1;
    }
    return t == 1;
}
// end: point-in-polygon

// start: segment-intersection
// 线段相交判定（返回类型和交点）
/*0-不相交，1-严格相交，2-重叠，3-在端点处相交*/
template <class T> tuple<int, Point<d128>, Point<d128>> segmentIntersection(const Line<T>& l1, const Line<T>& l2) {
    using P = Point<d128>;
    if(l1.a == l1.b && l2.a == l2.b)
        return l1.a == l2.a ? tuple{3, P(l1.a), P(l1.a)} : tuple{0, P(), P()};
    if(l1.a == l1.b)
        return pointOnSegment(l1.a, l2) ? tuple{3, P(l1.a), P(l1.a)} : tuple{0, P(), P()};
    if(l2.a == l2.b)
        return pointOnSegment(l2.a, l1) ? tuple{3, P(l2.a), P(l2.a)} : tuple{0, P(), P()};
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
// end: segment-intersection

// start: segment-in-polygon
// 线段是否在多边形内部
template <class T> bool segmentInPolygon(const Line<T>& l, const std::vector<Point<T>>& p) {
    int n = p.size();
    if(n == 0 || !pointInPolygon(l.a, p) || !pointInPolygon(l.b, p)) return false;
    if(l.a == l.b) return true;
    Point<d128> a = l.a, direction = Point<d128>(l.b) - a;
    d128 lengthSquared = square(direction);
    vector<d128> cut = {0, 1};
    for(int i = 0; i < n; i++) {
        auto [type, first, second] = segmentIntersection(l, Line<T>(p[i], p[(i + 1) % n]));
        if(type == 0) continue;
        cut.push_back(dot(first - a, direction) / lengthSquared);
        if(type == 2) cut.push_back(dot(second - a, direction) / lengthSquared);
    }
    sort(cut.begin(), cut.end());
    vector<Point<d128>> polygon(n);
    for(int i = 0; i < n; i++) polygon[i] = p[i];
    for(int i = 1; i < (int) cut.size(); i++) {
        if(cmp(cut[i] - cut[i - 1]) == 0) continue;
        d128 middle = (cut[i] + cut[i - 1]) / 2;
        if(cmp(middle) < 0 || cmp(middle - 1) > 0) continue;
        if(!pointInPolygon(a + direction * middle, polygon)) return false;
    }
    return true;
}
// end: segment-in-polygon
