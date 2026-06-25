#include <template/start.cpp>

struct CutDot {
    int n, tot;
    vector<vector<int>> g;
    vector<int> dfn, low, cut;
    CutDot(int _n, vector<vector<int>>& _g) : n(_n), g(_g) {
        dfn.resize(n + 1);
        low.resize(n + 1);
        cut.resize(n + 1);
        tot = 0;
    }

    void tarjan(int u, int root) {
        dfn[u] = low[u] = ++tot;
        int ch = 0;
        for(int v : g[u]) {
            if(!dfn[v]) {
                tarjan(v, root);
                low[u] = min(low[u], low[v]);
                if(low[v] >= dfn[u]) {
                    ch++;
                    if(u != root || ch > 1) cut[u] = 1;
                }
            } else
                low[u] = min(low[u], dfn[v]);
        }
    }
};
