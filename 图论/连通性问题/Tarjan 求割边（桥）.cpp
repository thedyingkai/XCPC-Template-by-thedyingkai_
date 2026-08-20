#include "../../template/start.cpp"

struct CutEdge {
    int n, m, tot, cnt;
    vector<int> dfn, low, parent, parentEdge, next;
    vector<vector<int>> g;
    struct edge {
        int u, v;
    };
    vector<edge> e, bri;
    CutEdge(int _n, int _m) : n(_n), m(_m) {
        g.resize(n + 1);
        dfn.resize(n + 1);
        low.resize(n + 1);
        parent.resize(n + 1);
        parentEdge.assign(n + 1, -1);
        next.resize(n + 1);
        tot = 0;
    }
    void add(int a, int b) {
        e.push_back({a, b});
        g[a].push_back(e.size() - 1);
        e.push_back({b, a});
        g[b].push_back(e.size() - 1);
    }

    void tarjan(int start, int = -1) {
        if(dfn[start]) return;
        vector<int> stk = {start};
        dfn[start] = low[start] = ++tot;
        while(!stk.empty()) {
            int u = stk.back();
            if(next[u] < (int) g[u].size()) {
                int j = g[u][next[u]++], v = e[j].v;
                if(j == (parentEdge[u] ^ 1)) continue;
                if(!dfn[v]) {
                    parent[v] = u, parentEdge[v] = j;
                    dfn[v] = low[v] = ++tot;
                    stk.push_back(v);
                } else
                    low[u] = min(low[u], dfn[v]);
                continue;
            }
            stk.pop_back();
            if(parent[u]) {
                int p = parent[u];
                low[p] = min(low[p], low[u]);
                if(low[u] > dfn[p]) bri.push_back({p, u});
            }
        }
    }
};
