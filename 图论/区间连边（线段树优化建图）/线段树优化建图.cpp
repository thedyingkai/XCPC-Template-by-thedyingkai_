#pragma once
#include "../../template/start.cpp"

struct RangeEdgeGraph {
    static constexpr i128 INF = (i128) 1 << 120;
    int n;
    vector<int> down, up;
    vector<vector<pair<int, i64>>> graph;

    explicit RangeEdgeGraph(int n_) : n(n_) {
        assert(n >= 1);
        down.resize(4 * n);
        up.resize(4 * n);
        graph.resize(n + 1);
        build(1, 1, n);
    }

    int newNode() { graph.emplace_back(); return (int) graph.size() - 1; }

    void build(int p, int l, int r) {
        if(l == r) { down[p] = up[p] = l; return; }
        down[p] = newNode(), up[p] = newNode();
        int mid = midpoint(l, r);
        build(p * 2, l, mid);
        build(p * 2 + 1, mid + 1, r);
        for(int child : {p * 2, p * 2 + 1}) {
            graph[down[p]].push_back({down[child], 0});
            graph[up[child]].push_back({up[p], 0});
        }
    }

    void linkRange(int p, int l, int r, int ql, int qr, int v, i64 w, bool toRange) {
        if(ql <= l && r <= qr) {
            if(toRange) graph[v].push_back({down[p], w});
            else graph[up[p]].push_back({v, w});
            return;
        }
        int mid = midpoint(l, r);
        if(ql <= mid) linkRange(p * 2, l, mid, ql, qr, v, w, toRange);
        if(qr > mid) linkRange(p * 2 + 1, mid + 1, r, ql, qr, v, w, toRange);
    }

    void addEdge(int u, int v, i64 w) {
        assert(1 <= u && u <= n && 1 <= v && v <= n && w >= 0);
        graph[u].push_back({v, w});
    }

    void pointToRange(int u, int l, int r, i64 w) {
        assert(1 <= u && u <= n && 1 <= l && l <= r && r <= n && w >= 0);
        linkRange(1, 1, n, l, r, u, w, true);
    }

    void rangeToPoint(int l, int r, int v, i64 w) {
        assert(1 <= v && v <= n && 1 <= l && l <= r && r <= n && w >= 0);
        linkRange(1, 1, n, l, r, v, w, false);
    }

    void rangeToRange(int l1, int r1, int l2, int r2, i64 w) {
        assert(1 <= l1 && l1 <= r1 && r1 <= n);
        assert(1 <= l2 && l2 <= r2 && r2 <= n && w >= 0);
        int bridge = newNode();
        linkRange(1, 1, n, l1, r1, bridge, 0, false);
        linkRange(1, 1, n, l2, r2, bridge, w, true);
    }

    vector<i128> dijkstra(int source) const {
        assert(1 <= source && source <= n);
        vector<i128> distance(graph.size(), INF);
        priority_queue<pair<i128, int>, vector<pair<i128, int>>, greater<>> q;
        distance[source] = 0;
        q.push({0, source});
        while(!q.empty()) {
            auto [d, u] = q.top(); q.pop();
            if(d != distance[u]) continue;
            for(auto [v, w] : graph[u])
                if(d + w < distance[v]) {
                    distance[v] = d + w;
                    q.push({distance[v], v});
                }
        }
        distance.resize(n + 1); // Only return the original vertices 1..n.
        return distance;
    }
};
