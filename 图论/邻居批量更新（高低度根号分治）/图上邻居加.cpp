#pragma once

#include "../../template/start.cpp"

struct NeighborAdd {
    int n, B;
    vector<vector<int>> g, adj;
    vector<int> id;
    vector<i64> direct, lazy;

    NeighborAdd(int n_, const vector<pair<int, int>>& edge)
        : n(n_), g(n + 1), id(n + 1, -1), direct(n + 1) {
        for(auto [u, v] : edge) {
            g[u].push_back(v), g[v].push_back(u);
        }
        int m = edge.size();
        B = max(1, (int) sqrt(max(1LL, 2LL * m)));
        int cnt = 0;
        for(int u = 1; u <= n; u++)
            if(g[u].size() >= B) id[u] = cnt++;
        lazy.assign(cnt, 0);
        adj.assign(n + 1, {});
        for(int u = 1; u <= n; u++)
            for(int v : g[u])
                if(id[v] != -1) adj[u].push_back(id[v]);
    }

    void addNeighbors(int u, i64 value) {
        if(id[u] != -1) lazy[id[u]] += value;
        else
            for(int v : g[u]) direct[v] += value;
    }

    i64 query(int u) const {
        i64 answer = direct[u];
        for(int v : adj[u]) answer += lazy[v];
        return answer;
    }
};
