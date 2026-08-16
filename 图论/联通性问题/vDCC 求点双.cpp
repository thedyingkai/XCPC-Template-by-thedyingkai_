#include "../../template/start.cpp"

struct VDCC {
    int n, tot, cnt;
    vector<vector<int>> g;
    vector<int> dfn, low, cut;
    vector<vector<int>> dcc;
    stack<int> stk;
    VDCC(int _n, vector<vector<int>>& _g) : n(_n), g(_g) {
        dfn.resize(n + 1);
        low.resize(n + 1);
        cut.resize(n + 1);
        tot = cnt = 0;
    }
    void tarjan(int u, int root) {
        dfn[u] = low[u] = ++tot;
        stk.push(u);
        if(g[u].empty()) {
            dcc.push_back({u});
            cnt++;
            stk.pop();
            return;
        }
        int ch = 0;
        for(int v : g[u]) {
            if(!dfn[v]) {
                tarjan(v, u);
                low[u] = min(low[u], low[v]);
                if(low[v] >= dfn[u]) {
                    ch++;
                    if(u != root || ch > 1) cut[u] = 1;
                    dcc.push_back({});
                    cnt++;
                    while(1) {
                        int z = stk.top();
                        stk.pop();
                        dcc.back().push_back(z);
                        if(z == v) break;
                    }
                    dcc.back().push_back(u);
                }
            } else if(v != root)
                low[u] = min(low[u], dfn[v]);
        }
    }
};
