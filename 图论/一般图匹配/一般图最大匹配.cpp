#pragma once

#include "../../template/start.cpp"

struct GeneralMatching {
    int n;
    vector<vector<int>> g;
    vector<int> mate, p, base, q;
    vector<int> used, blossom;
    GeneralMatching(int n_) : n(n_), g(n + 1) {}
    void add(int u, int v) {
        if(u == v) return;
        g[u].push_back(v), g[v].push_back(u);
    }
    int lca(int a, int b) {
        vector<int> vis(n + 1);
        while(true) {
            a = base[a], vis[a] = 1;
            if(!mate[a]) break;
            a = p[mate[a]];
        }
        while(true) {
            b = base[b];
            if(vis[b]) return b;
            b = p[mate[b]];
        }
    }
    void markPath(int v, int b, int child) {
        while(base[v] != b) {
            blossom[base[v]] = blossom[base[mate[v]]] = 1;
            p[v] = child;
            child = mate[v];
            v = p[mate[v]];
        }
    }
    int findPath(int root) {
        used.assign(n + 1, 0), p.assign(n + 1, 0);
        base.resize(n + 1);
        iota(base.begin(), base.end(), 0);
        q.clear(), q.push_back(root), used[root] = 1;
        for(int head = 0; head < (int) q.size(); head++) {
            int v = q[head];
            for(int u : g[v]) {
                if(base[v] == base[u] || mate[v] == u) continue;
                if(u == root || (mate[u] && p[mate[u]])) {
                    int b = lca(v, u);
                    blossom.assign(n + 1, 0);
                    markPath(v, b, u), markPath(u, b, v);
                    for(int x = 1; x <= n; x++) if(blossom[base[x]]) {
                        base[x] = b;
                        if(!used[x]) used[x] = 1, q.push_back(x);
                    }
                } else if(!p[u]) {
                    p[u] = v;
                    if(!mate[u]) return u;
                    u = mate[u], used[u] = 1, q.push_back(u);
                }
            }
        }
        return 0;
    }
    int maxMatching() {
        mate.assign(n + 1, 0);
        int ans = 0;
        for(int root = 1; root <= n; root++) if(!mate[root]) {
            int v = findPath(root);
            if(!v) continue;
            ans++;
            while(v) {
                int pv = p[v], next = mate[pv];
                mate[v] = pv, mate[pv] = v;
                v = next;
            }
        }
        return ans;
    }
};
