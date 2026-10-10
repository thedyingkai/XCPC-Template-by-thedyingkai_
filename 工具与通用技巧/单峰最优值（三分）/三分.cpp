#include "../../template/start.cpp"

double ternarySearch(double l, double r, auto&& f, double eps = 1e-7) {
    assert(isfinite(l) && isfinite(r) && isfinite(eps) && l <= r && eps > 0);
    while(r - l > eps) {
        double lm = lerp(l, r, 1.0 / 3);
        double rm = lerp(l, r, 2.0 / 3);
        double oldL = l, oldR = r;
        if(f(lm) < f(rm))
            l = lm;
        else
            r = rm;
        if(l == oldL && r == oldR) break;
    }
    return midpoint(l, r);
}
