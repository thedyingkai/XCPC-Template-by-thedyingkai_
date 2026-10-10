#pragma once

#include "../合法的整数极角比较器/整数极角.cpp"

// start: half-plane
// closed=false: 最大开半圆；closed=true: 最大闭半圆。
// 零向量不参与方向扫描，闭半平面中原点的数量由调用者另加。
int maxHalfPlane(vector<IP> a, bool closed = false) {
    a.erase(remove_if(a.begin(), a.end(), zeroVector), a.end());
    sort(a.begin(), a.end(), PolarLess());
    vector<IP> p;
    vector<int> w;
    for(const auto& v : a) {
        if(!p.empty() && sameRay(p.back(), v))
            w.back()++;
        else
            p.push_back(v), w.push_back(1);
    }
    int n = p.size();
    if(n == 0) return 0;
    vector<i64> pref(2 * n + 1);
    for(int i = 0; i < 2 * n; i++) pref[i + 1] = pref[i] + w[i % n];
    int ans = 0, j = 0;
    for(int i = 0; i < n; i++) {
        j = max(j, i + 1);
        while(j < i + n) {
            i128 c = cross(p[i], p[j % n]);
            if(c > 0 || (closed && c == 0 && dot(p[i], p[j % n]) < 0))
                j++;
            else
                break;
        }
        ans = max(ans, int(pref[j] - pref[i]));
    }
    return ans;
}
// end: half-plane
