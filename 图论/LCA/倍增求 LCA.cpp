#include <template/start.cpp>

struct LCA {
    int n;
    vector<vector<int>>&g, p;
    vector<int> dep;
    LCA(int n_, int root, vector<vector<int>>& g_) : n(n_), g(g_) {
        dep.resize(n + 1);
        p.assign(n + 1, vector<int>(20));
        dep[0] = 0;
        dfs(root, 0);
    }
    void dfs(int u, int fa) {
        dep[u] = dep[fa] + 1;
        p[u][0] = fa;
        for(int i = 1; i <= 19; i++) p[u][i] = p[p[u][i - 1]][i - 1];
        for(int v : g[u])
            if(v != fa) dfs(v, u);
    }
    int lca(int u, int v) {
        if(dep[u] < dep[v]) swap(u, v);
        for(int i = 19; i >= 0; i--) {
            if(dep[p[u][i]] >= dep[v]) u = p[u][i];
            if(u == v) return v;
        }
        for(int i = 19; i >= 0; i--)
            if(p[u][i] != p[v][i]) u = p[u][i], v = p[v][i];
        return p[u][0];
    }
};
