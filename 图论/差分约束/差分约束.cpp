#pragma once

#include "../../template/start.cpp"

struct DifferenceConstraints {
    struct Edge {
        int v;
        i128 w;
    };
    int n;
    vector<vector<Edge>> g;
    DifferenceConstraints(int n_) : n(n_), g(n + 1) {}
    // x[v] - x[u] <= c
    void addLeq(int u, int v, i128 c) { g[u].push_back({v, c}); }
    // x[v] - x[u] >= c
    void addGeq(int u, int v, i128 c) { addLeq(v, u, -c); }
    void addEqual(int u, int v, i128 c) {
        addLeq(u, v, c);
        addGeq(u, v, c);
    }
    pair<bool, vector<i128>> solve() const {
        vector<i128> dis(n + 1, 0);
        vector<int> len(n + 1), inq(n + 1, 1);
        queue<int> q;
        for(int i = 1; i <= n; i++) q.push(i);
        while(!q.empty()) {
            int u = q.front();
            q.pop(), inq[u] = 0;
            for(auto [v, w] : g[u]) {
                if(dis[v] <= dis[u] + w) continue;
                dis[v] = dis[u] + w;
                len[v] = len[u] + 1;
                if(len[v] >= n) return {false, {}};
                if(!inq[v]) q.push(v), inq[v] = 1;
            }
        }
        return {true, dis};
    }
};
