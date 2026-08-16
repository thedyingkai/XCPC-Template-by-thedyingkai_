#include "../../template/start.cpp"

struct CutEdge {
    int n, m, tot, cnt;
    vector<int> dfn, low;
    vector<vector<int>> g;
    struct edge {
        int u, v;
    };
    vector<edge> e, bri;
    CutEdge(int _n, int _m) : n(_n), m(_m) {
        g.resize(n + 1);
        dfn.resize(n + 1);
        low.resize(n + 1);
        tot = 0;
    }
    void add(int a, int b) {
        e.push_back({a, b});
        g[a].push_back(e.size() - 1);
        e.push_back({b, a});
        g[b].push_back(e.size() - 1);
    }

    void tarjan(int u, int in = -1) {
        dfn[u] = low[u] = ++tot;
        for(int j : g[u]) {
            int v = e[j].v;
            if(!dfn[v]) {
                tarjan(v, j);
                low[u] = min(low[u], low[v]);
                if(low[v] > dfn[u]) bri.emplace_back(u, v);
            } else if(j != (in ^ 1))
                low[u] = min(low[u], dfn[v]);
        }
    }
};
