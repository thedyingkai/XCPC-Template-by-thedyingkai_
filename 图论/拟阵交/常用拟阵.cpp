#pragma once

#include "拟阵交.cpp"

// start: partition-matroid
struct PartitionMatroidOracle final : MatroidOracle {
    int n;
    vector<int> group, capacity, count;
    vector<char> chosen;
    PartitionMatroidOracle(vector<int> group_, vector<int> capacity_)
        : n((int) group_.size()), group(move(group_)), capacity(move(capacity_)) {
        for(int value : capacity) assert(value >= 0);
        for(int x : group) assert(0 <= x && x < (int) capacity.size());
    }
    void reset(const vector<char>& in) override {
        assert((int) in.size() == n);
        chosen = in;
        count.assign(capacity.size(), 0);
        for(int i = 0; i < n; i++) if(chosen[i]) count[group[i]]++;
    }
    bool canAdd(int in) const override {
        return !chosen[in] && count[group[in]] < capacity[group[in]];
    }
    bool canExchange(int out, int in) const override {
        if(!chosen[out] || chosen[in]) return false;
        int need = count[group[in]] + 1 - (group[out] == group[in]);
        return need <= capacity[group[in]];
    }
};
// end: partition-matroid

// start: unit-partition-matroid-intersection
vector<int> unitPartitionMatroidIntersection(const PartitionMatroidOracle& first,
                                             const PartitionMatroidOracle& second) {
    assert(first.n == second.n);
    for(int value : first.capacity) assert(0 <= value && value <= 1);
    for(int value : second.capacity) assert(0 <= value && value <= 1);

    int n = first.n;
    vector<vector<int>> byFirst(first.capacity.size());
    for(int id = 0; id < n; id++) {
        int u = first.group[id], v = second.group[id];
        if(first.capacity[u] && second.capacity[v]) byFirst[u].push_back(id);
    }

    vector<int> mateFirst(first.capacity.size(), -1), mateSecond(second.capacity.size(), -1);
    vector<int> dis(first.capacity.size()), cur(first.capacity.size());
    int shortest;

    auto bfs = [&]() {
        queue<int> q;
        fill(dis.begin(), dis.end(), -1);
        for(int u = 0; u < (int) first.capacity.size(); u++) {
            if(first.capacity[u] && mateFirst[u] == -1) dis[u] = 0, q.push(u);
        }
        fill(cur.begin(), cur.end(), 0);
        shortest = -1;
        while(!q.empty()) {
            int u = q.front();
            q.pop();
            if(shortest != -1 && dis[u] + 1 > shortest) continue;
            for(int id : byFirst[u]) {
                if(mateFirst[u] == id) continue;
                int v = second.group[id];
                if(mateSecond[v] == -1) {
                    shortest = dis[u] + 1;
                } else {
                    int next = first.group[mateSecond[v]];
                    if(dis[next] == -1) dis[next] = dis[u] + 1, q.push(next);
                }
            }
        }
        return shortest != -1;
    };

    auto augment = [&](int start) {
        vector<int> firstPath = {start}, elementPath;
        firstPath.reserve(shortest + 1), elementPath.reserve(shortest);
        while(!firstPath.empty()) {
            int u = firstPath.back();
            bool advanced = false;
            while(cur[u] < (int) byFirst[u].size()) {
                int id = byFirst[u][cur[u]++];
                if(mateFirst[u] == id) continue;
                int v = second.group[id];
                if(mateSecond[v] == -1) {
                    if(dis[u] + 1 != shortest) continue;
                    elementPath.push_back(id);
                    for(int i = (int) firstPath.size() - 1; i >= 0; i--) {
                        int add = elementPath[i];
                        mateFirst[firstPath[i]] = add;
                        mateSecond[second.group[add]] = add;
                    }
                    return true;
                }
                int next = first.group[mateSecond[v]];
                if(dis[next] != dis[u] + 1) continue;
                elementPath.push_back(id), firstPath.push_back(next);
                advanced = true;
                break;
            }
            if(advanced) continue;
            dis[u] = -1;
            bool hasParent = firstPath.size() > 1;
            firstPath.pop_back();
            if(hasParent) elementPath.pop_back();
        }
        return false;
    };

    while(bfs()) {
        for(int u = 0; u < (int) first.capacity.size(); u++) {
            if(first.capacity[u] && mateFirst[u] == -1) augment(u);
        }
    }

    vector<int> answer;
    for(int id : mateFirst) if(id != -1) answer.push_back(id);
    return answer;
}
// end: unit-partition-matroid-intersection

// start: graphic-matroid
struct GraphicMatroidOracle final : MatroidOracle {
    struct Edge {
        int u, v;
    };
    int vertices, m, clk;
    vector<Edge> edges;
    vector<char> chosen;
    vector<vector<pair<int, int>>> g;
    vector<int> component, tin, tout, edgeChild, seen;
    vector<array<int, 3>> dfsStack;
    GraphicMatroidOracle(int vertices_, vector<Edge> edges_)
        : vertices(vertices_), m((int) edges_.size()), clk(0), edges(move(edges_)),
          g(vertices + 1) {
        dfsStack.reserve(2 * vertices + 1);
    }
    void reset(const vector<char>& in) override {
        chosen = in, clk = 0;
        for(auto& adj : g) adj.clear();
        for(int id = 0; id < m; id++) if(chosen[id]) {
            auto [u, v] = edges[id];
            g[u].push_back({v, id}), g[v].push_back({u, id});
        }
        component.assign(vertices + 1, 0), tin.assign(vertices + 1, 0), tout.assign(vertices + 1, 0);
        edgeChild.assign(m, 0);
        seen.assign(vertices + 1, 0);
        for(int s = 1; s <= vertices; s++) if(!seen[s]) {
            dfsStack.clear();
            dfsStack.push_back({s, -1, 0});
            while(!dfsStack.empty()) {
                auto [u, pe, exit] = dfsStack.back();
                dfsStack.pop_back();
                if(exit) {
                    tout[u] = clk;
                    continue;
                }
                if(seen[u]) continue;
                seen[u] = 1, component[u] = s, tin[u] = ++clk;
                if(pe != -1) edgeChild[pe] = u;
                dfsStack.push_back({u, pe, 1});
                for(auto [v, id] : g[u]) if(id != pe) dfsStack.push_back({v, id, 0});
            }
        }
    }
    bool inside(int subtreeRoot, int u) const {
        return component[subtreeRoot] == component[u] &&
               tin[subtreeRoot] <= tin[u] && tin[u] <= tout[subtreeRoot];
    }
    bool canAdd(int in) const override {
        auto [u, v] = edges[in];
        return !chosen[in] && u != v && component[u] != component[v];
    }
    bool canExchange(int out, int in) const override {
        if(!chosen[out] || chosen[in]) return false;
        auto [u, v] = edges[in];
        if(u == v) return false;
        if(component[u] != component[v]) return true;
        int child = edgeChild[out];
        return child && (inside(child, u) ^ inside(child, v));
    }
};
// end: graphic-matroid
