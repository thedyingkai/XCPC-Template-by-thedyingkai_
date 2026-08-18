#pragma once

#include "拟阵交.cpp"

// start: partition-matroid
struct PartitionMatroidOracle : MatroidOracle {
    int n;
    vector<int> group, capacity, count;
    vector<char> chosen;
    PartitionMatroidOracle(vector<int> group_, vector<int> capacity_)
        : n((int) group_.size()), group(move(group_)), capacity(move(capacity_)) {
        for(int x : group) assert(0 <= x && x < (int) capacity.size());
    }
    void reset(const vector<char>& in) override {
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

// start: graphic-matroid
struct GraphicMatroidOracle : MatroidOracle {
    struct Edge {
        int u, v;
    };
    int vertices, m, clk;
    vector<Edge> edges;
    vector<char> chosen;
    vector<vector<pair<int, int>>> g;
    vector<int> component, tin, tout, edgeChild;
    GraphicMatroidOracle(int vertices_, vector<Edge> edges_)
        : vertices(vertices_), m((int) edges_.size()), clk(0), edges(move(edges_)), g(vertices + 1) {}
    void reset(const vector<char>& in) override {
        chosen = in, clk = 0;
        for(auto& adj : g) adj.clear();
        for(int id = 0; id < m; id++) if(chosen[id]) {
            auto [u, v] = edges[id];
            g[u].push_back({v, id}), g[v].push_back({u, id});
        }
        component.assign(vertices + 1, 0), tin.assign(vertices + 1, 0), tout.assign(vertices + 1, 0);
        edgeChild.assign(m, 0);
        vector<int> seen(vertices + 1);
        for(int s = 1; s <= vertices; s++) if(!seen[s]) {
            vector<array<int, 4>> stk{{s, 0, -1, 0}};
            while(!stk.empty()) {
                auto [u, p, pe, exit] = stk.back();
                stk.pop_back();
                if(exit) {
                    tout[u] = clk;
                    continue;
                }
                if(seen[u]) continue;
                seen[u] = 1, component[u] = s, tin[u] = ++clk;
                if(pe != -1) edgeChild[pe] = u;
                stk.push_back({u, p, pe, 1});
                for(auto [v, id] : g[u]) if(v != p) stk.push_back({v, u, id, 0});
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
