#pragma once

#include "点与直线基础.cpp"

// 半平面交（返回交点多边形）
template <class T> vector<Point<d128>> hp(const vector<Line<T>>& input) {
    using P = Point<d128>;
    using L = Line<d128>;
    vector<L> lines;
    lines.reserve(input.size());
    for(const auto& l : input) {
        assert(l.a != l.b);
        lines.emplace_back((P) l.a, (P) l.b);
    }
    sort(lines.begin(), lines.end(), [&](const L& l1, const L& l2) {
        auto d1 = l1.b - l1.a, d2 = l2.b - l2.a;
        auto upper = [](const P& d) { return d.y > 0 || (d.y == 0 && d.x > 0); };
        if(upper(d1) != upper(d2)) return upper(d1);
        return cross(d1, d2) > 0;
    });
    vector<L> filtered;
    for(const auto& l : lines) {
        if(!filtered.empty()) {
            auto d1 = filtered.back().b - filtered.back().a, d2 = l.b - l.a;
            if(cmp(cross(d1, d2)) == 0 && cmp(dot(d1, d2)) > 0) {
                if(!pointOnLineLeft(filtered.back().a, l)) filtered.back() = l;
                continue;
            }
        }
        filtered.push_back(l);
    }
    // 只返回二维有界交集，交点落在新边界上时也弹出旧边界。
    auto outside = [](const P& p, const L& l) { return cmp(cross(l.b - l.a, p - l.a)) <= 0; };
    deque<L> ls;
    deque<P> ps;
    for(const auto& l : filtered) {
        while(!ps.empty() && outside(ps.back(), l)) ps.pop_back(), ls.pop_back();
        while(!ps.empty() && outside(ps.front(), l)) ps.pop_front(), ls.pop_front();
        if(!ls.empty() && parallel(ls.back(), l)) return {};
        if(!ls.empty()) ps.push_back(lineIntersection(ls.back(), l));
        ls.push_back(l);
    }
    while(!ps.empty() && outside(ps.back(), ls.front())) ps.pop_back(), ls.pop_back();
    while(!ps.empty() && outside(ps.front(), ls.back())) ps.pop_front(), ls.pop_front();
    if(ls.size() <= 2) return {};
    if(parallel(ls.back(), ls.front())) return {};
    ps.push_back(lineIntersection(ls.back(), ls.front()));
    d128 area = 0;
    for(int i = 1; i + 1 < (int) ps.size(); i++) area += cross(ps[i] - ps[0], ps[i + 1] - ps[0]);
    if(cmp(area) <= 0) return {};
    return vector(ps.begin(), ps.end());
}
