#include <template/start.cpp>

struct LCA {
    int n, m;
    vector<vector<int>>& g;
    vector<vector<pair<int, int>>>& q;
    vector<int> p, vis, ans;
    LCA(int n_, int m_, int root, vector<vector<int>>& g_, vector<vector<pair<int, int>>>& q_)
        : n(n_), m(m_), g(g_), q(q_) {
        p.resize(n + 1);
        vis.resize(n + 1);
        ans.resize(m + 1);
        iota(p.begin(), p.end(), 0);
        tarjan(root);
    }
    int find(int u) {
        if(u == p[u]) return u;
        return p[u] = find(p[u]);
    }
    void tarjan(int u) {
        vis[u] = 1;
        for(int v : g[u])
            if(!vis[v]) {
                tarjan(v);
                p[v] = u;
            }
        for(auto [v, i] : q[u])
            if(vis[v]) ans[i] = find(v);
    }
};
