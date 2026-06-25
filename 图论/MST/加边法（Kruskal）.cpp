#include <template/start.cpp>

struct Kruskal {
    struct Edge {
        int u, v, w;
        bool operator<(const Edge& other) const { return w < other.w; }
    };
    int n, cnt, f;
    i64 ans;
    vector<Edge>& g;
    vector<int> p;
    Kruskal(int n_, vector<Edge>& g_) : n(n_), g(g_) {
        p.resize(n + 1);
        f = kruskal();
    }
    int find(int x) { return p[x] == x ? x : p[x] = find(p[x]); }
    bool kruskal() {
        sort(g.begin(), g.end());
        iota(p.begin(), p.end(), 0);
        ans = cnt = 0;
        for(auto& e : g) {
            int x = find(e.u), y = find(e.v);
            if(x != y) {
                p[x] = y, ans += e.w, cnt++;
                if(cnt == n - 1) break;
            }
        }
        return cnt == n - 1;
    }
};
