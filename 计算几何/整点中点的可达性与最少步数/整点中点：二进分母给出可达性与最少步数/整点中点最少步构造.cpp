#pragma once

#include "../../圆周方向统计（极角排序与扫描）/合法的整数极角比较器/整数极角.cpp"

// start: midpoint
// 0<=x<=a；返回约分后 x/a 的二进分母指数，不可达为 -1。
int dyadicDepth(i64 a, i64 x) {
    assert(0 <= x && x <= a);
    if(a == 0) return 0;
    u64 den = a / gcd(a, x);
    if((den & (den - 1)) != 0) return -1;
    return countr_zero(den);
}
// 返回每一步所选的两点；nullopt 为不可达，空数组表示目标已是初始顶点。
optional<vector<pair<IP, IP>>> midpointConstruction(i64 a, i64 b, IP target) {
    int kx = dyadicDepth(a, target.x), ky = dyadicDepth(b, target.y);
    if(kx < 0 || ky < 0) return nullopt;
    int k = max(kx, ky);
    vector<pair<IP, IP>> ans;
    IP cur = target;
    for(int i = 0; i < k; i++) {
        IP corner((i128) 2 * cur.x >= a ? a : 0, (i128) 2 * cur.y >= b ? b : 0);
        IP parent((i64) ((i128) 2 * cur.x - corner.x), (i64) ((i128) 2 * cur.y - corner.y));
        ans.push_back({parent, corner});
        cur = parent;
    }
    assert((cur.x == 0 || cur.x == a) && (cur.y == 0 || cur.y == b));
    reverse(ans.begin(), ans.end());
    return ans;
}
// end: midpoint
