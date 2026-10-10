#pragma once

#include "../../点线基础与夹角计算/角度归一化、圆周接缝与零向量/角度计算.cpp"

// start: coverage-width
// 返回 {存在一个朝向覆盖 k 点, 每个朝向都覆盖 k 点} 的最小闭角宽。
// 非零向量，可同向、可重复；角宽是弧度。1 <= k <= a.size()。
pair<d128, d128> coverageWidth(const vector<IP>& p, int k) {
    int n = p.size();
    assert(1 <= k && k <= n);
    vector<d128> a(2 * n);
    for(int i = 0; i < n; i++) {
        assert(!zeroVector(p[i]));
        a[i] = normAngle(atan2l((d128) p[i].y, (d128) p[i].x));
    }
    sort(a.begin(), a.begin() + n);
    for(int i = 0; i < n; i++) a[i + n] = a[i] + 2 * GEOM_PI;
    d128 some = 2 * GEOM_PI, every = 0;
    for(int i = 0; i < n; i++) {
        some = min(some, a[i + k - 1] - a[i]);
        every = max(every, a[i + k] - a[i]);
    }
    return {some, every};
}
// end: coverage-width
