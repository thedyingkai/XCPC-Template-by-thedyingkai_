#include "../../template/start.cpp"

struct CutDot {
    struct Edge {
        int u, v;
    };
    int n, tot, stamp;
    vector<Edge> edges;
    vector<vector<pair<int, int>>> g;
    vector<int> dfn, low, cut, mark, parent, parentEdge, next, child;
    vector<vector<int>> bcc;
    CutDot(int n_, const vector<vector<int>>& graph) : n(n_), tot(0), stamp(0), g(n + 1) {
        for(int u = 1; u <= n; u++)
            for(int v : graph[u]) if(u < v) addEdge(u, v);
        dfn.resize(n + 1), low.resize(n + 1), cut.resize(n + 1), mark.resize(n + 1);
        parent.resize(n + 1), parentEdge.assign(n + 1, -1), next.resize(n + 1), child.resize(n + 1);
    }
    void addEdge(int u, int v) {
        int id = (int) edges.size();
        edges.push_back({u, v});
        g[u].push_back({v, id}), g[v].push_back({u, id});
    }
    void tarjan(int start, int = 0) {
        if(dfn[start]) return;
        vector<int> stack = {start}, edgeStack;
        dfn[start] = low[start] = ++tot;
        while(!stack.empty()) {
            int u = stack.back();
            if(next[u] < (int) g[u].size()) {
                auto [v, id] = g[u][next[u]++];
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
                if(g[u].empty()) bcc.push_back({u});
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
            bcc.push_back(move(block));
        }
    }
};
