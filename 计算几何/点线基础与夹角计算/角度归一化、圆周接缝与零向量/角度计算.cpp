#pragma once

#include "../../圆周方向统计（极角排序与扫描）/合法的整数极角比较器/整数极角.cpp"

// start: angle
constexpr d128 GEOM_PI = numbers::pi_v<d128>;
d128 normAngle(d128 a, d128 period = 2 * GEOM_PI) {
    assert(isfinite(a) && isfinite(period) && period > 0);
    a = fmodl(a, period);
    if(a < 0) a += period;
    if(a >= period) a = 0;
    return a == 0 ? 0.0L : a;
}
d128 signedAngle(const IP& a, const IP& b) {
    assert(!zeroVector(a) && !zeroVector(b));
    return atan2l((d128) cross(a, b), (d128) dot(a, b));
}
// end: angle
