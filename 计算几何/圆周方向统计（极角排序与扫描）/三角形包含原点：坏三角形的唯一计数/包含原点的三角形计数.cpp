#pragma once

#include "../合法的整数极角比较器/整数极角.cpp"

// start: origin-triangles
// 统计严格包含原点的三角形。
// 前提：所有向量非零，任意两向量不共线（不允许同向或反向）。
i128 countOriginTriangles(vector<IP> a) {
    for(const auto& p : a) assert(!zeroVector(p));
    sort(a.begin(), a.end(), PolarLess());
    int n = a.size();
    for(int i = 1; i < n; i++) assert(!sameRay(a[i - 1], a[i]));
    i128 ans = (i128) n * (n - 1) * (n - 2) / 6;
    int j = 0;
    for(int i = 0; i < n; i++) {
        j = max(j, i + 1);
        while(j < i + n && cross(a[i], a[j % n]) > 0) j++;
        if(j < i + n) assert(cross(a[i], a[j % n]) != 0);
        i64 k = j - i - 1;
        ans -= (i128) k * (k - 1) / 2;
    }
    return ans;
}
// end: origin-triangles
