#include "点与直线基础.cpp"

// start: convex-hull
template <class T> vector<Point<T>> convexHull(vector<Point<T>> p, bool keepCollinear = false) {
    sort(p.begin(), p.end(), [](const Point<T>& a, const Point<T>& b) { return a.x != b.x ? a.x < b.x : a.y < b.y; });
    p.erase(unique(p.begin(), p.end()), p.end());
    int n = p.size();
    if(n <= 2) return p;
    bool collinear = true;
    for(int i = 2; i < n; i++)
        if(cmp(cross(p[1] - p[0], p[i] - p[0])) != 0) collinear = false;
    if(collinear && keepCollinear) return p;
    vector<Point<T>> q(2 * n);
    int k = 0;
    for(int i = 0; i < n; i++) {
        while(k >= 2) {
            int t = cmp(cross(q[k - 1] - q[k - 2], p[i] - q[k - 1]));
            if(t > 0 || (keepCollinear && t == 0)) break;
            k--;
        }
        q[k++] = p[i];
    }
    for(int i = n - 2, t = k + 1; i >= 0; i--) {
        while(k >= t) {
            int c = cmp(cross(q[k - 1] - q[k - 2], p[i] - q[k - 1]));
            if(c > 0 || (keepCollinear && c == 0)) break;
            k--;
        }
        q[k++] = p[i];
    }
    q.resize(k - 1);
    return q;
}
// end: convex-hull

// start: diameter
template <class T> auto diameter2(const vector<Point<T>>& p) {
    using R = decltype(square(Point<T>()));
    int n = p.size();
    if(n <= 1) return R(0);
    if(n == 2) return R(square(p[0] - p[1]));
    auto absv = [](R x) { return x < 0 ? -x : x; };
    R ans = 0;
    int j = 1;
    for(int i = 0; i < n; i++) {
        int ni = (i + 1) % n;
        while(absv(R(cross(p[ni] - p[i], p[(j + 1) % n] - p[i]))) > absv(R(cross(p[ni] - p[i], p[j] - p[i]))))
            j = (j + 1) % n;
        ans = max(ans, R(square(p[i] - p[j])));
        ans = max(ans, R(square(p[ni] - p[j])));
    }
    return ans;
}
// end: diameter
