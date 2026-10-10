#pragma once

#include "../../圆周方向统计（极角排序与扫描）/合法的整数极角比较器/整数极角.cpp"

// start: convex-query
// 逆时针严格凸包，不重复首点；允许空集、单点、线段。
// 返回 -1 外部，0 边界，1 严格内部。n>=3 时 O(log n)。
int convexLocation(const vector<IP>& p, const IP& q) {
    int n = p.size();
    if(n == 0) return -1;
    if(n == 1) return p[0] == q ? 0 : -1;
    if(n == 2) return pointOnSegment(q, Line<i64>(p[0], p[1])) ? 0 : -1;
    i128 a = orient128(p[0], p[1], q), b = orient128(p[0], p[n - 1], q);
    if(a < 0 || b > 0) return -1;
    if(a == 0) return pointOnSegment(q, Line<i64>(p[0], p[1])) ? 0 : -1;
    if(b == 0) return pointOnSegment(q, Line<i64>(p[0], p[n - 1])) ? 0 : -1;
    int l = 1, r = n - 1;
    while(r - l > 1) {
        int mid = (l + r) / 2;
        if(orient128(p[0], p[mid], q) >= 0)
            l = mid;
        else
            r = mid;
    }
    i128 c = orient128(p[l], p[r], q);
    return c < 0 ? -1 : (c == 0 ? 0 : 1);
}
// end: convex-query
