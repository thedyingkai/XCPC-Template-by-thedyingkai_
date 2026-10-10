#pragma once

#include "../../圆周方向统计（极角排序与扫描）/合法的整数极角比较器/整数极角.cpp"

// start: polygon-area
// 返回两倍有向面积；逆时针为正，顺时针为负。
i128 signedArea2(const vector<IP>& p) {
    i128 ans = 0;
    for(int i = 0; i < (int) p.size(); i++) ans += cross(p[i], p[(i + 1) % p.size()]);
    return ans;
}
// end: polygon-area
