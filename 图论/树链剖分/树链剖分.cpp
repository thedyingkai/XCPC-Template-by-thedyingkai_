#ifndef XCPC_HLD
#define XCPC_HLD

#include "../../template/start.cpp"

struct HLD {
    int n, root, tot;
    const vector<vector<int>>& g;
    vector<int> p, dep, sz, son, top, dfn, rk;
    HLD(int n_, int root_, vector<vector<int>>& g_) : n(n_), root(root_), tot(0), g(g_) {
        p.resize(n + 1);
        dep.resize(n + 1);
        sz.resize(n + 1);
        son.resize(n + 1);
        top.resize(n + 1);
        dfn.resize(n + 1);
        rk.resize(n + 1);
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
        top[u] = t, dfn[u] = ++tot, rk[tot] = u;
        if(son[u]) dfs2(son[u], t);
        for(int v : g[u]) {
            if(v == p[u] || v == son[u]) continue;
            dfs2(v, v);
        }
    }
    int lca(int u, int v) const {
        while(top[u] != top[v]) {
            if(dep[top[u]] < dep[top[v]]) swap(u, v);
            u = p[top[u]];
        }
        return dep[u] < dep[v] ? u : v;
    }
    template <class F> void path(int u, int v, F&& f, bool edge = false) const {
        while(top[u] != top[v]) {
            if(dep[top[u]] < dep[top[v]]) swap(u, v);
            f(dfn[top[u]], dfn[u]);
            u = p[top[u]];
        }
        if(dep[u] > dep[v]) swap(u, v);
        int l = dfn[u] + edge;
        if(l <= dfn[v]) f(l, dfn[v]);
    }
    pair<int, int> subtree(int u, bool edge = false) const { return {dfn[u] + edge, dfn[u] + sz[u] - 1}; }
};

#endif
