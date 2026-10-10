#pragma once

#include "../../template/start.cpp"

struct UnicyclicGraph {
    struct Edge {
        int u, v;
        i64 w;
    };
    int n;
    vector<Edge> e;
    vector<vector<pair<int, int>>> g;
    vector<int> onCycle, cycle, cycleEdge, cyclePos;
    vector<int> root, parent, parentEdge, dep;
    vector<i64> dist, pref;
    UnicyclicGraph(int n_) : n(n_), g(n + 1) {}
    int addEdge(int u, int v, i64 w = 1) {
        int id = (int) e.size();
        e.push_back({u, v, w});
        g[u].push_back({v, id}), g[v].push_back({u, id});
        return id;
    }
    bool build() {
        if((int) e.size() != n || n == 0) return false;
        cycle.clear(), cycleEdge.clear(), pref.clear();
        vector<int> seen(n + 1), deg(n + 1), removed(n + 1);
        queue<int> q;
        q.push(1), seen[1] = 1;
        int reached = 0;
        while(!q.empty()) {
            int u = q.front();
            q.pop(), reached++;
            for(auto [v, id] : g[u]) if(!seen[v]) seen[v] = 1, q.push(v);
        }
        if(reached != n) return false;
        for(int u = 1; u <= n; u++) {
            deg[u] = (int) g[u].size();
            if(deg[u] <= 1) q.push(u);
        }
        while(!q.empty()) {
            int u = q.front();
            q.pop();
            if(removed[u]) continue;
            removed[u] = 1;
            for(auto [v, id] : g[u]) if(!removed[v]) {
                if(--deg[v] == 1) q.push(v);
            }
        }
        onCycle.assign(n + 1, 0), cyclePos.assign(n + 1, -1);
        int start = 0, cycleCount = 0;
        for(int u = 1; u <= n; u++) if(!removed[u]) onCycle[u] = 1, start = u, cycleCount++;
        if(!start) return false;
        int u = start, lastEdge = -1;
        do {
            if(cyclePos[u] != -1) return false;
            cyclePos[u] = (int) cycle.size();
            cycle.push_back(u);
            int id = -1, v = 0;
            for(auto [to, eid] : g[u]) {
                if(onCycle[to] && eid != lastEdge) {
                    id = eid, v = to;
                    break;
                }
            }
            if(id == -1) return false;
            cycleEdge.push_back(id);
            lastEdge = id, u = v;
        } while(u != start && (int) cycle.size() <= n);
        if(u != start || (int) cycle.size() != cycleCount) return false;
        pref.assign(cycle.size() + 1, 0);
        for(int i = 0; i < (int) cycle.size(); i++) pref[i + 1] = pref[i] + e[cycleEdge[i]].w;
        root.assign(n + 1, 0), parent.assign(n + 1, 0), parentEdge.assign(n + 1, -1);
        dep.assign(n + 1, 0), dist.assign(n + 1, 0);
        for(int x : cycle) root[x] = x, q.push(x);
        while(!q.empty()) {
            int x = q.front();
            q.pop();
            for(auto [v, id] : g[x]) {
                if(onCycle[v] || root[v]) continue;
                root[v] = root[x], parent[v] = x, parentEdge[v] = id;
                dep[v] = dep[x] + 1, dist[v] = dist[x] + e[id].w;
                q.push(v);
            }
        }
        for(int x = 1; x <= n; x++) if(!root[x]) return false;
        return true;
    }
    i64 clockwiseDistance(int u, int v) const {
        int x = cyclePos[u], y = cyclePos[v];
        assert(x != -1 && y != -1);
        if(x <= y) return pref[y] - pref[x];
        return pref.back() - pref[x] + pref[y];
    }
    i64 shorterCycleDistance(int u, int v) const {
        i64 a = clockwiseDistance(u, v);
        return min(a, pref.back() - a);
    }
};
