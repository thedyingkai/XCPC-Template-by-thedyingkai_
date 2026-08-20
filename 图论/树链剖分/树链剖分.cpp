#pragma once

#include "../../template/start.cpp"

struct HLD {
    int n, root, tot;
    const vector<vector<int>>& g;
    vector<int> p, dep, sz, son, top, dfn, rk;
    HLD(int n_, int root_, const vector<vector<int>>& g_) : n(n_), root(root_), tot(0), g(g_) {
        p.resize(n + 1);
        dep.resize(n + 1);
        sz.resize(n + 1);
        son.resize(n + 1);
        top.resize(n + 1);
        dfn.resize(n + 1);
        rk.resize(n + 1);
        build();
    }
    void build() {
        tot = 0;
        fill(p.begin(), p.end(), 0), fill(dep.begin(), dep.end(), 0);
        fill(sz.begin(), sz.end(), 0), fill(son.begin(), son.end(), 0);
        fill(top.begin(), top.end(), 0), fill(dfn.begin(), dfn.end(), 0), fill(rk.begin(), rk.end(), 0);
        vector<int> order, stk = {root};
        order.reserve(n);
        dep[root] = 1;
        while(!stk.empty()) {
            int u = stk.back();
            stk.pop_back();
            order.push_back(u);
            for(int v : g[u]) {
                if(v == p[u]) continue;
                p[v] = u, dep[v] = dep[u] + 1;
                stk.push_back(v);
            }
        }
        for(auto it = order.rbegin(); it != order.rend(); ++it) {
            int u = *it;
            sz[u] = 1;
            for(int v : g[u]) {
                if(p[v] != u) continue;
                sz[u] += sz[v];
                if(!son[u] || sz[v] > sz[son[u]]) son[u] = v;
            }
        }
        vector<pair<int, int>> chains = {{root, root}};
        while(!chains.empty()) {
            auto [u, t] = chains.back();
            chains.pop_back();
            for(; u; u = son[u]) {
                top[u] = t, dfn[u] = ++tot, rk[tot] = u;
                for(int v : g[u])
                    if(p[v] == u && v != son[u]) chains.push_back({v, v});
            }
        }
    }
    int lca(int u, int v) const {
        while(top[u] != top[v]) {
            if(dep[top[u]] < dep[top[v]]) swap(u, v);
            u = p[top[u]];
        }
        return dep[u] < dep[v] ? u : v;
    }
    void path(int u, int v, auto&& f, bool edge = false) const {
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
