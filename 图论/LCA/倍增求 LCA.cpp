#include "../../template/start.cpp"

struct LCA {
    int n, lg;
    const vector<vector<int>>& g;
    vector<vector<int>> p;
    vector<int> dep;
    LCA(int n_, int root, const vector<vector<int>>& g_) : n(n_), g(g_) {
        lg = 1;
        while((1LL << lg) <= n) lg++;
        dep.resize(n + 1);
        p.assign(n + 1, vector<int>(lg));
        build(root);
    }
    void build(int root) {
        assert(1 <= root && root <= n);
        dep.assign(n + 1, 0);
        p.assign(n + 1, vector<int>(lg));
        dep[root] = 1;
        vector<int> stk = {root};
        while(!stk.empty()) {
            int u = stk.back();
            stk.pop_back();
            for(int i = 1; i < lg; i++) p[u][i] = p[p[u][i - 1]][i - 1];
            for(int v : g[u]) if(v != p[u][0]) {
                p[v][0] = u, dep[v] = dep[u] + 1;
                stk.push_back(v);
            }
        }
    }
    int jump(int u, int k) const {
        if(k < 0) return 0;
        for(int i = 0; i < lg; i++) if(k >> i & 1) u = p[u][i];
        return k >> lg ? 0 : u;
    }
    int lca(int u, int v) const {
        if(dep[u] < dep[v]) swap(u, v);
        for(int i = lg - 1; i >= 0; i--) {
            if(dep[p[u][i]] >= dep[v]) u = p[u][i];
            if(u == v) return v;
        }
        for(int i = lg - 1; i >= 0; i--)
            if(p[u][i] != p[v][i]) u = p[u][i], v = p[v][i];
        return p[u][0];
    }
};
