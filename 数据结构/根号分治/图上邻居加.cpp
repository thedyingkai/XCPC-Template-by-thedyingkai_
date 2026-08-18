#pragma once

#include "../../template/start.cpp"

struct NeighborAdd {
    int n, threshold;
    vector<vector<int>> graph, heavyNeighbor;
    vector<int> heavyId;
    vector<i64> direct, lazy;

    NeighborAdd(int n_, const vector<pair<int, int>>& edge)
        : n(n_), graph(n + 1), heavyId(n + 1, -1), direct(n + 1) {
        for(auto [u, v] : edge) {
            assert(1 <= u && u <= n && 1 <= v && v <= n);
            graph[u].push_back(v), graph[v].push_back(u);
        }
        threshold = max(1, (int) sqrt(max(1, 2 * (int) edge.size())));
        int heavyCount = 0;
        for(int u = 1; u <= n; u++)
            if((int) graph[u].size() >= threshold) heavyId[u] = heavyCount++;
        lazy.assign(heavyCount, 0);
        heavyNeighbor.assign(n + 1, {});
        for(int u = 1; u <= n; u++)
            for(int v : graph[u])
                if(heavyId[v] != -1) heavyNeighbor[u].push_back(heavyId[v]);
    }

    void addNeighbors(int u, i64 value) {
        assert(1 <= u && u <= n);
        if(heavyId[u] != -1) lazy[heavyId[u]] += value;
        else
            for(int v : graph[u]) direct[v] += value;
    }

    i64 query(int u) const {
        assert(1 <= u && u <= n);
        i64 answer = direct[u];
        for(int id : heavyNeighbor[u]) answer += lazy[id];
        return answer;
    }
};
