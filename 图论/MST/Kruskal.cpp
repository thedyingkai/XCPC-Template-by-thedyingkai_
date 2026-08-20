#include "../../template/start.cpp"

struct Kruskal {
    struct Edge {
        int u, v, w;
        bool operator<(const Edge& other) const { return w < other.w; }
    };
    int n, cnt, f;
    i64 ans;
    vector<Edge>& g;
    vector<int> p, sz;
    Kruskal(int n_, vector<Edge>& g_) : n(n_), g(g_) {
        p.resize(n + 1);
        sz.resize(n + 1);
        f = kruskal();
    }
    int find(int x) {
        int root = x;
        while(p[root] != root) root = p[root];
        while(p[x] != x) {
            int next = p[x];
            p[x] = root;
            x = next;
        }
        return root;
    }
    bool kruskal() {
        sort(g.begin(), g.end());
        iota(p.begin(), p.end(), 0);
        fill(sz.begin(), sz.end(), 1);
        ans = cnt = 0;
        for(auto& e : g) {
            int x = find(e.u), y = find(e.v);
            if(x != y) {
                if(sz[x] < sz[y]) swap(x, y);
                p[y] = x, sz[x] += sz[y], ans += e.w, cnt++;
                if(cnt == n - 1) break;
            }
        }
        return cnt == n - 1;
    }
};
