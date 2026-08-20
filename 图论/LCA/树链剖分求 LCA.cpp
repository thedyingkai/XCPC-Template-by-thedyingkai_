#include "../../template/start.cpp"

struct LCA {
    int n;
    const vector<vector<int>>& g;
    vector<int> p, dep, son, sz, top;
    LCA(int n_, int root, const vector<vector<int>>& g_) : n(n_), g(g_) {
        p.resize(n + 1);
        dep.resize(n + 1);
        son.resize(n + 1);
        sz.resize(n + 1);
        top.resize(n + 1);
        build(root);
    }
    void build(int root) {
        assert(1 <= root && root <= n);
        fill(p.begin(), p.end(), 0);
        fill(dep.begin(), dep.end(), 0);
        fill(son.begin(), son.end(), 0);
        fill(sz.begin(), sz.end(), 0);
        fill(top.begin(), top.end(), 0);
        vector<int> order, stk = {root};
        order.reserve(n), dep[root] = 1;
        while(!stk.empty()) {
            int u = stk.back();
            stk.pop_back(), order.push_back(u);
            for(int v : g[u]) if(v != p[u]) {
                p[v] = u, dep[v] = dep[u] + 1;
                stk.push_back(v);
            }
        }
        for(auto it = order.rbegin(); it != order.rend(); ++it) {
            int u = *it;
            sz[u] = 1;
            for(int v : g[u]) if(p[v] == u) {
                sz[u] += sz[v];
                if(!son[u] || sz[v] > sz[son[u]]) son[u] = v;
            }
        }
        vector<pair<int, int>> chains = {{root, root}};
        while(!chains.empty()) {
            auto [u, t] = chains.back();
            chains.pop_back();
            for(; u; u = son[u]) {
                top[u] = t;
                for(int v : g[u]) if(p[v] == u && v != son[u]) chains.push_back({v, v});
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
};
