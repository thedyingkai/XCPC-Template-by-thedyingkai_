#include "../../template/start.cpp"

template <class F> double ternarySearch(double l, double r, F f, double eps = 1e-7) {
    while(r - l > eps) {
        double lm = (2 * l + r) / 3;
        double rm = (l + 2 * r) / 3;
        if(f(lm) < f(rm))
            l = lm;
        else
            r = rm;
    }
    return (l + r) / 2;
}
