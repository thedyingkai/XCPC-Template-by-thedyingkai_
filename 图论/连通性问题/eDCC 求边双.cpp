#include "../../template/start.cpp"

struct EDCC {
    int n, m, tot, cnt, idx;
    struct Edge {
        int v, ne;
    };
    vector<int> g, dfn, low, dcc, bri, parent, parentEdge, next;
    vector<Edge> e;
    EDCC(int _n, int _m) : n(_n), m(_m) {
        dfn.resize(n + 1);
        low.resize(n + 1);
        dcc.resize(n + 1);
        g.resize(n + 1);
        bri.resize(2 * m + 2);
        e.resize(2 * m + 2);
        parent.resize(n + 1), parentEdge.assign(n + 1, -1), next.resize(n + 1);
        tot = cnt = 0, idx = 1;
    }
    void add(int u, int v) {
        e[++idx] = {v, g[u]};
        g[u] = idx;
        e[++idx] = {u, g[v]};
        g[v] = idx;
    }
    void tarjan(int start, int = 0) {
        if(dfn[start]) return;
        vector<int> vertices, stk = {start};
        dfn[start] = low[start] = ++tot, next[start] = g[start], vertices.push_back(start);
        while(!stk.empty()) {
            int u = stk.back(), i = next[u];
            if(i) {
                next[u] = e[i].ne;
                if(i == (parentEdge[u] ^ 1)) continue;
                int v = e[i].v;
                if(!dfn[v]) {
                    parent[v] = u, parentEdge[v] = i;
                    dfn[v] = low[v] = ++tot, next[v] = g[v], vertices.push_back(v);
                    stk.push_back(v);
                } else
                    low[u] = min(low[u], dfn[v]);
                continue;
            }
            stk.pop_back();
            if(parent[u]) {
                int p = parent[u], i = parentEdge[u];
                low[p] = min(low[p], low[u]);
                if(low[u] > dfn[p]) bri[i] = bri[i ^ 1] = 1;
            }
        }
        for(int s : vertices) if(!dcc[s]) {
            ++cnt;
            vector<int> component = {s};
            dcc[s] = cnt;
            while(!component.empty()) {
                int u = component.back();
                component.pop_back();
                for(int i = g[u]; i; i = e[i].ne) if(!bri[i]) {
                    int v = e[i].v;
                    if(!dcc[v]) dcc[v] = cnt, component.push_back(v);
                }
            }
        }
    }
};
