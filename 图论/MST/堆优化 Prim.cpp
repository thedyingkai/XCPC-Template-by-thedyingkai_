#include "../../template/start.cpp"

struct Prim {
    int n, cnt, f;
    i64 ans;
    const vector<vector<pair<int, int>>>& g;
    vector<i64> d;
    vector<int> vis, parent;
    Prim(int n_, const vector<vector<pair<int, int>>>& g_) : n(n_), g(g_) {
        d.resize(n + 1, LLONG_MAX);
        vis.resize(n + 1);
        parent.resize(n + 1);
        f = prim(1);
    }
    bool prim(int s) {
        fill(d.begin(), d.end(), LLONG_MAX);
        fill(vis.begin(), vis.end(), 0);
        fill(parent.begin(), parent.end(), 0);
        d[s] = 0, ans = 0, cnt = 0;
        priority_queue<pair<i64, int>, vector<pair<i64, int>>, greater<>> pq;
        pq.emplace(0, s);
        while(!pq.empty()) {
            int u = pq.top().second;
            pq.pop();
            if(vis[u]) continue;
            vis[u] = 1, ans += d[u], cnt++;
            for(auto [v, w] : g[u]) {
                if(!vis[v] && w < d[v]) {
                    d[v] = w, parent[v] = u;
                    pq.emplace(d[v], v);
                }
            }
        }
        return cnt == n;
    }
};
