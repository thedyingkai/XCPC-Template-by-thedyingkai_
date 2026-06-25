#include <template/start.cpp>

struct SCC {
    int n, tot, cnt;
    vector<vector<int>> g;
    vector<int> dfn, low, vis, scc, sz;
    stack<int> stk;
    SCC(int _n, vector<vector<int>>& _g) : n(_n), g(_g) {
        dfn.resize(n + 1);
        low.resize(n + 1);
        vis.resize(n + 1);
        scc.resize(n + 1);
        sz.resize(n + 1);
        tot = cnt = 0;
    }

    void tarjan(int u) {
        dfn[u] = low[u] = ++tot;
        stk.push(u), vis[u] = 1;
        for(int v : g[u]) {
            if(!dfn[v]) {
                tarjan(v);
                low[u] = min(low[u], low[v]);
            } else if(vis[v])
                low[u] = min(low[u], dfn[v]);
        }
        if(dfn[u] == low[u]) {
            int v;
            cnt++;
            do {
                v = stk.top();
                stk.pop();
                vis[v] = 0;
                scc[v] = cnt;
                sz[cnt]++;
            } while(v != u);
        }
    }
};
