#include "../../template/start.cpp"

struct Prim {
    int n, cnt, f;
    i64 ans;
    vector<vector<pair<int, int>>>& g;
    vector<i64> d;
    vector<int> vis;
    Prim(int n_, vector<vector<pair<int, int>>>& g_) : n(n_), g(g_) {
        d.resize(n + 1, LLONG_MAX);
        vis.resize(n + 1);
        f = prim(1);
    }
    bool prim(int s) {
        d[s] = 0, ans = 0, cnt = 0;
        priority_queue<pair<int, int>> pq;
        pq.emplace(0, s);
        while(!pq.empty()) {
            int u = pq.top().second;
            pq.pop();
            if(vis[u]) continue;
            vis[u] = 1, ans += d[u], cnt++;
            for(auto [v, w] : g[u]) {
                if(!vis[v] && w < d[v]) {
                    d[v] = w;
                    pq.emplace(-d[v], v);
                }
            }
        }
        return cnt == n;
    }
};
