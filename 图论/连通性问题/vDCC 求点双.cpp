#include "../../template/start.cpp"

struct VDCC {
    struct Edge {
        int u, v;
    };
    int n, tot, cnt, stamp;
    const vector<vector<int>>& g;
    vector<Edge> edges;
    vector<vector<pair<int, int>>> adj;
    vector<int> dfn, low, cut, mark, parent, parentEdge, next, child;
    vector<vector<int>> dcc;
    VDCC(int n_, const vector<vector<int>>& g_)
        : n(n_), tot(0), cnt(0), stamp(0), g(g_), adj(n + 1), dfn(n + 1), low(n + 1),
          cut(n + 1), mark(n + 1), parent(n + 1), parentEdge(n + 1, -1), next(n + 1), child(n + 1) {
        for(int u = 1; u <= n; u++)
            for(int v : g[u]) if(u < v) addEdge(u, v);
    }
    void addEdge(int u, int v) {
        int id = (int) edges.size();
        edges.push_back({u, v});
        adj[u].push_back({v, id}), adj[v].push_back({u, id});
    }
    void tarjan(int start, int = 0) {
        if(dfn[start]) return;
        vector<int> stack = {start}, edgeStack;
        dfn[start] = low[start] = ++tot;
        while(!stack.empty()) {
            int u = stack.back();
            if(next[u] < (int) adj[u].size()) {
                auto [v, id] = adj[u][next[u]++];
                if(id == parentEdge[u]) continue;
                if(!dfn[v]) {
                    parent[v] = u, parentEdge[v] = id, child[u]++;
                    edgeStack.push_back(id);
                    dfn[v] = low[v] = ++tot;
                    stack.push_back(v);
                } else if(dfn[v] < dfn[u]) {
                    low[u] = min(low[u], dfn[v]);
                    edgeStack.push_back(id);
                }
                continue;
            }
            stack.pop_back();
            int p = parent[u];
            if(!p) {
                cut[u] = child[u] > 1;
                if(adj[u].empty()) dcc.push_back({u}), cnt++;
                continue;
            }
            low[p] = min(low[p], low[u]);
            if(low[u] < dfn[p]) continue;
            if(parent[p] || child[p] > 1) cut[p] = 1;
            vector<int> block;
            ++stamp;
            while(true) {
                int id = edgeStack.back();
                edgeStack.pop_back();
                auto [a, b] = edges[id];
                if(mark[a] != stamp) mark[a] = stamp, block.push_back(a);
                if(mark[b] != stamp) mark[b] = stamp, block.push_back(b);
                if(id == parentEdge[u]) break;
            }
            dcc.push_back(move(block)), cnt++;
        }
    }
};
