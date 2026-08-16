#include "../联通性问题/Tarjan SCC 缩点.cpp"

struct TwoSAT {
    int n;
    vector<vector<int>> g;
    vector<int> ans;
    TwoSAT(int n_) : n(n_), g(2 * n + 1), ans(n + 1) {}
    int id(int x, bool val) const { return x + (val ? 0 : n); }
    int neg(int u) const { return u > n ? u - n : u + n; }
    void addEdge(int u, int v) { g[u].push_back(v); }
    void imply(int x, bool xv, int y, bool yv) {
        int u = id(x, xv), v = id(y, yv);
        addEdge(u, v);
        addEdge(neg(v), neg(u));
    }
    void either(int x, bool xv, int y, bool yv) {
        int u = id(x, xv), v = id(y, yv);
        addEdge(neg(u), v);
        addEdge(neg(v), u);
    }
    void force(int x, bool xv) { either(x, xv, x, xv); }
    bool solve() {
        SCC scc(2 * n, g);
        scc.work();
        for(int i = 1; i <= n; i++) {
            if(scc.scc[id(i, 0)] == scc.scc[id(i, 1)]) return false;
            ans[i] = scc.scc[id(i, 1)] < scc.scc[id(i, 0)];
        }
        return true;
    }
};
