#pragma once

#include "../../template/start.cpp"

struct SCC {
    int n, tot, cnt;
    const vector<vector<int>>& g;
    vector<int> dfn, low, vis, scc, sz;
    stack<int> stk;
    SCC(int _n, const vector<vector<int>>& _g) : n(_n), g(_g) {
        dfn.resize(n + 1);
        low.resize(n + 1);
        vis.resize(n + 1);
        scc.resize(n + 1);
        sz.resize(n + 1);
        tot = cnt = 0;
    }

    void tarjan(int start) {
        vector<pair<int, int>> call;
        call.push_back({start, 0});
        dfn[start] = low[start] = ++tot;
        stk.push(start), vis[start] = 1;
        while(!call.empty()) {
            int u = call.back().first;
            int& index = call.back().second;
            if(index < (int) g[u].size()) {
                int v = g[u][index++];
                if(!dfn[v]) {
                    dfn[v] = low[v] = ++tot;
                    stk.push(v), vis[v] = 1;
                    call.push_back({v, 0});
                } else if(vis[v])
                    low[u] = min(low[u], dfn[v]);
                continue;
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
            call.pop_back();
            if(!call.empty()) {
                int parent = call.back().first;
                low[parent] = min(low[parent], low[u]);
            }
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
