#pragma once

#include "../../template/start.cpp"

struct KruskalReconstructionTree {
    struct Edge {
        int u, v;
        i64 w;
    };
    int n, tot, lg;
    bool ascending;
    vector<int> dsu, dep, component, leaves;
    vector<i64> val;
    vector<vector<int>> child, up;
    KruskalReconstructionTree(int n_, vector<Edge> edges, bool ascending_ = true)
        : n(n_), tot(n_), ascending(ascending_) {
        build(move(edges));
    }
    int find(int x) {
        int root = x;
        while(dsu[root] != root) root = dsu[root];
        while(dsu[x] != x) {
            int next = dsu[x];
            dsu[x] = root;
            x = next;
        }
        return root;
    }
    bool pass(i64 x, i64 limit) const { return ascending ? x <= limit : x >= limit; }
    void build(vector<Edge> edges) {
        int cap = max(2 * n + 5, 5);
        dsu.resize(cap), val.resize(cap), child.resize(cap);
        iota(dsu.begin(), dsu.end(), 0);
        i64 leafValue = ascending ? numeric_limits<i64>::lowest() : numeric_limits<i64>::max();
        for(int i = 1; i <= n; i++) val[i] = leafValue;
        sort(edges.begin(), edges.end(), [&](const Edge& a, const Edge& b) {
            return ascending ? a.w < b.w : a.w > b.w;
        });
        for(auto [u, v, w] : edges) {
            int x = find(u), y = find(v);
            if(x == y) continue;
            ++tot, val[tot] = w;
            child[tot] = {x, y};
            dsu[tot] = tot, dsu[x] = dsu[y] = tot;
        }
        vector<int> roots;
        for(int i = 1; i <= n; i++) roots.push_back(find(i));
        sort(roots.begin(), roots.end());
        roots.erase(unique(roots.begin(), roots.end()), roots.end());
        dep.assign(tot + 1, 0), component.assign(tot + 1, 0), leaves.assign(tot + 1, 0);
        vector<int> parent(tot + 1), order;
        for(int r : roots) {
            component[r] = r, dep[r] = 1;
            vector<int> stk{r};
            while(!stk.empty()) {
                int u = stk.back();
                stk.pop_back(), order.push_back(u);
                for(int v : child[u]) {
                    parent[v] = u, dep[v] = dep[u] + 1, component[v] = r;
                    stk.push_back(v);
                }
            }
        }
        for(int i = (int) order.size() - 1; i >= 0; i--) {
            int u = order[i];
            if(u <= n) leaves[u] = 1;
            else for(int v : child[u]) leaves[u] += leaves[v];
        }
        lg = 1;
        while((1 << lg) <= max(tot, 1)) lg++;
        up.assign(lg, vector<int>(tot + 1));
        for(int u = 1; u <= tot; u++) up[0][u] = parent[u];
        for(int j = 1; j < lg; j++)
            for(int u = 1; u <= tot; u++) up[j][u] = up[j - 1][up[j - 1][u]];
    }
    int lca(int u, int v) const {
        if(component[u] != component[v]) return 0;
        if(dep[u] < dep[v]) swap(u, v);
        int d = dep[u] - dep[v];
        for(int j = 0; j < lg; j++) if(d >> j & 1) u = up[j][u];
        if(u == v) return u;
        for(int j = lg - 1; j >= 0; j--) if(up[j][u] != up[j][v]) u = up[j][u], v = up[j][v];
        return up[0][u];
    }
    optional<i64> mergeValue(int u, int v) const {
        int w = lca(u, v);
        if(!w) return nullopt;
        return val[w];
    }
    int componentNode(int u, i64 limit) const {
        for(int j = lg - 1; j >= 0; j--) {
            int a = up[j][u];
            if(a && pass(val[a], limit)) u = a;
        }
        return u;
    }
};
