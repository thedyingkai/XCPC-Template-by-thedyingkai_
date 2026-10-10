#pragma once

#include "../../圆周方向统计（极角排序与扫描）/合法的整数极角比较器/整数极角.cpp"

// start: minkowski
// 输入为 convexHull(..., false) 的输出。O(n+m)，返回同样的凸包格式。
// 坐标加减仍在 i64 内完成，须保证坐标、边向量和结果坐标装入 i64。
vector<IP> minkowskiSum(vector<IP> a, vector<IP> b) {
    if(a.empty() || b.empty()) return {};
    auto startAtLowest = [](vector<IP>& p) {
        auto it = min_element(p.begin(), p.end(), [](const IP& u, const IP& v) {
            return u.y != v.y ? u.y < v.y : u.x < v.x;
        });
        rotate(p.begin(), it, p.end());
    };
    startAtLowest(a);
    startAtLowest(b);
    if(a.size() == 1) {
        for(auto& p : b) p += a[0];
        return b;
    }
    if(b.size() == 1) {
        for(auto& p : a) p += b[0];
        return a;
    }
    int n = a.size(), m = b.size();
    vector<IP> ea(n), eb(m);
    for(int i = 0; i < n; i++) ea[i] = a[(i + 1) % n] - a[i];
    for(int j = 0; j < m; j++) eb[j] = b[(j + 1) % m] - b[j];
    vector<IP> ans{a[0] + b[0]};
    int i = 0, j = 0;
    while(i < n || j < m) {
        IP step;
        if(i == n)
            step = eb[j++];
        else if(j == m)
            step = ea[i++];
        else if(sameRay(ea[i], eb[j]))
            step = ea[i++] + eb[j++];
        else if(PolarLess()(ea[i], eb[j]))
            step = ea[i++];
        else
            step = eb[j++];
        ans.push_back(ans.back() + step);
    }
    ans.pop_back(); // 最后一步回到首点。
    return ans;
}
vector<IP> minkowskiDifference(const vector<IP>& a, vector<IP> b) {
    for(auto& p : b) p = -p; // 旋转 180 度，保持逆时针。
    return minkowskiSum(a, b);
}
// end: minkowski
