#include "../../template/start.cpp"

struct LCA {
    int n;
    const vector<vector<int>>& g;
    vector<int> p, dep, son, sz, top;
    LCA(int n_, int root, vector<vector<int>>& g_) : n(n_), g(g_) {
        p.resize(n + 1);
        dep.resize(n + 1);
        son.resize(n + 1);
        sz.resize(n + 1);
        top.resize(n + 1);
        dep[0] = 0;
        dfs1(root, 0);
        dfs2(root, root);
    }
    void dfs1(int u, int fa) {
        p[u] = fa, dep[u] = dep[fa] + 1, sz[u] = 1;
        for(int v : g[u]) {
            if(v == fa) continue;
            dfs1(v, u);
            sz[u] += sz[v];
            if(sz[son[u]] < sz[v]) son[u] = v;
        }
    }
    void dfs2(int u, int t) {
        top[u] = t;
        if(!son[u]) return;
        dfs2(son[u], t);
        for(int v : g[u]) {
            if(v == p[u] || v == son[u]) continue;
            dfs2(v, v);
        }
    }
    int lca(int u, int v) {
        while(top[u] != top[v]) {
            if(dep[top[u]] < dep[top[v]]) swap(u, v);
            u = p[top[u]];
        }
        return dep[u] < dep[v] ? u : v;
    }
};
