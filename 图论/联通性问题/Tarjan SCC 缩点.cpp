#ifndef XCPC_TARJAN_SCC
#define XCPC_TARJAN_SCC

#include "../../template/start.cpp"

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
    void work() {
        for(int i = 1; i <= n; i++)
            if(!dfn[i]) tarjan(i);
    }
    vector<vector<int>> shrink() {
        work();
        vector<vector<int>> ng(cnt + 1);
        for(int u = 1; u <= n; u++)
            for(int v : g[u])
                if(scc[u] != scc[v]) ng[scc[u]].push_back(scc[v]);
        for(int i = 1; i <= cnt; i++) {
            sort(ng[i].begin(), ng[i].end());
            ng[i].erase(unique(ng[i].begin(), ng[i].end()), ng[i].end());
        }
        return ng;
    }
};

#endif
