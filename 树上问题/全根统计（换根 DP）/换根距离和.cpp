#pragma once
#include "../../template/start.cpp"

// answer[u] = sum_v mass[v] * distance(u, v).
vector<i128> rerootDistanceSum(
    const vector<vector<pair<int, i64>>>& graph, const vector<i64>& mass) {
    int n = (int) graph.size() - 1;
    assert(n >= 1 && (int) mass.size() == n + 1);
    vector<int> parent(n + 1, -1), order{1};
    vector<i64> edgeWeight(n + 1);
    vector<i128> subtree(n + 1), answer(n + 1);
    parent[1] = 0;
    for(int i = 0; i < (int) order.size(); i++) {
        int u = order[i];
        subtree[u] = mass[u];
        for(auto [v, w] : graph[u]) {
            if(v == parent[u]) continue;
            assert(parent[v] == -1);
            parent[v] = u;
            edgeWeight[v] = w;
            order.push_back(v);
        }
    }
    assert((int) order.size() == n);
    for(int i = n - 1; i > 0; i--) {
        int u = order[i], p = parent[u];
        subtree[p] += subtree[u];
        answer[p] += answer[u] + subtree[u] * edgeWeight[u];
    }
    for(int i = 1; i < n; i++) {
        int u = order[i], p = parent[u];
        answer[u] = answer[p] + (subtree[1] - 2 * subtree[u]) * edgeWeight[u];
    }
    return answer;
}
