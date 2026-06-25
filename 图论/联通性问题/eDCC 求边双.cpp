#include <template/start.cpp>

struct EDCC {
    int n, m, tot, cnt, idx;
    struct Edge {
        int v, ne;
    };
    vector<int> g, dfn, low, dcc, bri;
    vector<Edge> e;
    stack<int> stk;
    EDCC(int _n, int _m) : n(_n), m(_m) {
        dfn.resize(n + 1);
        low.resize(n + 1);
        dcc.resize(n + 1);
        g.resize(n + 1);
        bri.resize(2 * m + 2);
        e.resize(2 * m + 2);
        tot = cnt = 0, idx = 1;
    }
    void add(int u, int v) {
        e[++idx] = {v, g[u]};
        g[u] = idx;
        e[++idx] = {u, g[v]};
        g[v] = idx;
    }
    void tarjan(int u, int in = 0) {
        dfn[u] = low[u] = ++tot;
        stk.push(u);
        for(int i = g[u]; i; i = e[i].ne) {
            int v = e[i].v;
            if(!dfn[v]) {
                tarjan(v, i);
                low[u] = min(low[u], low[v]);
                if(low[v] > dfn[u]) bri[i] = bri[i ^ 1] = 1;
            } else if(i != (in ^ 1))
                low[u] = min(low[u], dfn[v]);
        }
        if(dfn[u] == low[u]) {
            cnt++;
            while(1) {
                int v = stk.top();
                stk.pop();
                dcc[v] = cnt;
                if(u == v) break;
            }
        }
    }
};
