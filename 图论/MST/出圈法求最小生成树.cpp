#include <template/start.cpp>

struct Prim {
    int n, ans, cnt, f;
    vector<vector<pair<int, int>>>& g;
    vector<int> d, vis;
    Prim(int n_, vector<vector<pair<int, int>>>& g_) : n(n_), g(g_) {
        d.resize(n + 1, INT_MAX);
        vis.resize(n + 1);
        f = prim(1);
    }
    bool prim(int s) {
        d[s] = 0, ans = 0, cnt = 0;
        for(int i = 1; i <= n; i++) {
            int u = 0;
            for(int j = 1; j <= n; j++)
                if(!vis[j] && d[j] < d[u]) u = j;
            if(u == 0) break;
            vis[u] = 1, ans += d[u], cnt++;
            for(auto [v, w] : g[u])
                if(!vis[v] && w < d[v]) d[v] = w;
        }
        return cnt == n;
    }
};
