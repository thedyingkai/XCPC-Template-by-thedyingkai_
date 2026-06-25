#include <template/start.cpp>

int main() {
    double eps = 1e-7, l, r;
    auto f = [&](double x) -> double {
        // TODO
    };
    while(r - l > eps) {
        double mid = (r + l) / 2;
        double lm = mid - eps, rm = mid + eps;
        if(f(lm) > f(rm))
            r = mid;
        else
            l = mid;
    }
    cout << fixed << setprecision(5) << l;
}
