#include <template/start.cpp>

struct RectUnion {
    struct St {
        i64 x1, x2;
        int y, o;
        St() {}
        St(i64 _x1, i64 _x2, int _y, int _o) : x1(_x1), x2(_x2), y(_y), o(_o) {}
    };
    int n, tot;
    vector<int> a;
    vector<i64> v, w;
    vector<St> b;
    RectUnion(int n_ = 0) {
        n = n_;
        a.resize(n * 2);
        v.resize(n * 8);
        w.resize(n * 8);
        b.resize(n * 2);
    }
    int f(int y) { return lower_bound(a.begin(), a.begin() + tot, y) - a.begin(); }
    void up(int u, int ul, int ur) {
        if(v[u])
            w[u] = a[ur] - a[ul];
        else if(ul + 1 == ur)
            w[u] = 0;
        else
            w[u] = w[u * 2 + 1] + w[u * 2 + 2];
    }
    void add(int lf, int rg, i64 o, int u = 0, int ul = 0, int ur = -1) {
        if(ur == -1) ur = tot - 1;
        if(lf == ul && rg == ur) {
            v[u] += o;
            up(u, ul, ur);
            return;
        }
        int um = (ul + ur) / 2;
        if(lf < um) add(lf, min(rg, um), o, u * 2 + 1, ul, um);
        if(um < rg) add(max(lf, um), rg, o, u * 2 + 2, um, ur);
        up(u, ul, ur);
    }
    i64 fuck() {
        sort(a.begin(), a.begin() + n * 2);
        tot = 1;
        for(int i = 1; i < n * 2; i++)
            if(a[i] != a[tot - 1]) a[tot++] = a[i];
        sort(b.begin(), b.begin() + n * 2, [](St& i, St& j) { return i.y < j.y; });
        i64 sum = 0;
        add(f(b[0].x1), f(b[0].x2), 1);
        for(int i = 1; i < n * 2; i++) {
            sum += (b[i].y - b[i - 1].y) * w[0];
            add(f(b[i].x1), f(b[i].x2), b[i].o);
        }
        return sum;
    }
};
int main() {
    int n;
    cin >> n;
    RectUnion ru(n);
    for(int i = 0; i < n; i++) {
        int x1, y1, x2, y2;
        cin >> x1 >> y1 >> x2 >> y2;
        ru.b[i] = RectUnion::St(x1, x2, y1, 1);
        ru.b[i + ru.n] = RectUnion::St(x1, x2, y2, -1);
        ru.a[i] = x1;
        ru.a[i + ru.n] = x2;
    }
    cout << ru.fuck() << '\n';
}
