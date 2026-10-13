#pragma once
#include <bits/stdc++.h>
namespace communication {

// simple_graph 已含给定简单环；cycle 按环上次序列出所有目标点。
// 环点排在其他点之前，除闭环边外均从低排名指向高排名。
std::vector<std::pair<int, int>> encode_cycle(
    int n, const std::vector<std::pair<int, int>> &simple_graph,
    const std::vector<int> &cycle) {
    if (cycle.size() < 3)
        throw std::invalid_argument("cycle too short");
    std::vector<int> rank(n, -1);
    int next = 0;
    for (int u : cycle) {
        if (u < 0 || u >= n || rank[u] != -1)
            throw std::invalid_argument("invalid cycle");
        rank[u] = next++;
    }
    for (int u = 0; u < n; ++u)
        if (rank[u] == -1) rank[u] = next++;
    int first = cycle.front(), last = cycle.back();
    std::vector<std::pair<int, int>> edges;
    for (auto [u, v] : simple_graph) {
        if (u < 0 || u >= n || v < 0 || v >= n || u == v)
            throw std::invalid_argument("invalid simple edge");
        if ((u == first && v == last) ||
            (u == last && v == first))
            edges.push_back({last, first});
        else if (rank[u] < rank[v]) edges.push_back({u, v});
        else edges.push_back({v, u});
    }
    return edges;
}

// 只承诺恢复上述构造的图；允许任意重新编号，结果可循环旋转。
std::vector<int> decode_cycle(
    int n, const std::vector<std::pair<int, int>> &edges) {
    int m = edges.size();
    std::vector<std::vector<int>> in(n), out(n);
    std::vector<int> degree(n), indegree(n);
    for (int i = 0; i < m; ++i) {
        auto [u, v] = edges[i];
        if (u < 0 || u >= n || v < 0 || v >= n)
            throw std::invalid_argument("invalid endpoint");
        out[u].push_back(i);
        in[v].push_back(i);
        ++degree[u];
    }
    std::queue<int> queue;
    std::vector<bool> alive(n, true), active(m);
    for (int u = 0; u < n; ++u)
        if (!degree[u]) queue.push(u);
    while (!queue.empty()) {
        int v = queue.front(); queue.pop();
        alive[v] = false;
        for (int id : in[v]) {
            int u = edges[id].first;
            if (--degree[u] == 0) queue.push(u);
        }
    }
    int count = 0, start = -1;
    for (int u = 0; u < n; ++u)
        if (alive[u]) { ++count; start = u; }
    if (count < 3) throw std::invalid_argument("missing target cycle");
    for (int i = 0; i < m; ++i) {
        auto [u, v] = edges[i];
        if (alive[u] && alive[v]) {
            active[i] = true;
            ++indegree[v];
        }
    }
    for (int u = 0; u < n; ++u)
        if (alive[u] && indegree[u] == 1) queue.push(u);
    std::vector<int> successor(n, -1);
    while (!queue.empty()) {
        int v = queue.front(); queue.pop();
        int forced = -1;
        for (int id : in[v])
            if (active[id]) { forced = id; break; }
        if (forced == -1)
            throw std::invalid_argument("invalid forced graph");
        int u = edges[forced].first;
        if (successor[u] != -1) continue;
        successor[u] = v;
        for (int id : out[u])
            if (active[id] && id != forced) {
                active[id] = false;
                int to = edges[id].second;
                if (--indegree[to] == 1) queue.push(to);
            }
    }
    std::vector<int> cycle;
    std::vector<bool> seen(n);
    int u = start;
    while (u != -1 && alive[u] && !seen[u]) {
        seen[u] = true;
        cycle.push_back(u);
        u = successor[u];
    }
    if (u != start || cycle.size() != count)
        throw std::invalid_argument("target cycle not determined");
    return cycle;
}

} // namespace communication
