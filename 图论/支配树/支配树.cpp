#pragma once

#include "../../template/start.cpp"

struct DominatorTree {
    int n, root;
    vector<vector<int>> g, tree;
    vector<int> idom, dfn, tin, tout;
    DominatorTree(int n_) : n(n_), root(0), g(n + 1) {}
    void add(int u, int v) { g[u].push_back(v); }
    const vector<int>& build(int s) {
        root = s;
        dfn.assign(n + 1, 0);
        vector<int> rev(n + 1), parent(n + 1), it(n + 1);
        vector<vector<int>> pred(n + 1);
        int tim = 0;
        dfn[s] = ++tim, rev[tim] = s;
        vector<int> stk{s};
        while(!stk.empty()) {
            int u = stk.back();
            if(it[u] == (int) g[u].size()) {
                stk.pop_back();
                continue;
            }
            int v = g[u][it[u]++];
            if(!dfn[v]) {
                dfn[v] = ++tim, rev[tim] = v;
                parent[dfn[v]] = dfn[u];
                stk.push_back(v);
            }
            pred[dfn[v]].push_back(dfn[u]);
        }
        vector<int> semi(tim + 1), label(tim + 1), ancestor(tim + 1), dom(tim + 1);
        vector<vector<int>> bucket(tim + 1);
        iota(semi.begin(), semi.end(), 0);
        iota(label.begin(), label.end(), 0);
        auto eval = [&](int v) {
            if(!ancestor[v]) return label[v];
            vector<int> path;
            int x = v;
            while(ancestor[ancestor[x]]) path.push_back(x), x = ancestor[x];
            for(int i = (int) path.size() - 1; i >= 0; i--) {
                int u = path[i], a = ancestor[u];
                if(semi[label[a]] < semi[label[u]]) label[u] = label[a];
                ancestor[u] = ancestor[a];
            }
            return label[v];
        };
        for(int w = tim; w >= 2; w--) {
            for(int v : pred[w]) semi[w] = min(semi[w], semi[eval(v)]);
            bucket[semi[w]].push_back(w);
            ancestor[w] = parent[w];
            int p = parent[w];
            for(int v : bucket[p]) {
                int u = eval(v);
                dom[v] = semi[u] < semi[v] ? u : p;
            }
            bucket[p].clear();
        }
        for(int w = 2; w <= tim; w++) if(dom[w] != semi[w]) dom[w] = dom[dom[w]];
        idom.assign(n + 1, -1), idom[s] = 0;
        tree.assign(n + 1, {});
        for(int w = 2; w <= tim; w++) {
            int u = rev[w], p = rev[dom[w]];
            idom[u] = p, tree[p].push_back(u);
        }
        tin.assign(n + 1, 0), tout.assign(n + 1, 0);
        int clk = 0;
        vector<pair<int, int>> tour{{s, 0}};
        while(!tour.empty()) {
            auto [u, exit] = tour.back();
            tour.pop_back();
            if(!exit) {
                tin[u] = ++clk;
                tour.push_back({u, 1});
                for(int i = (int) tree[u].size() - 1; i >= 0; i--) tour.push_back({tree[u][i], 0});
            } else
                tout[u] = clk;
        }
        return idom;
    }
    bool reachable(int u) const { return 1 <= u && u <= n && !dfn.empty() && dfn[u]; }
    bool dominates(int u, int v) const {
        return reachable(u) && reachable(v) && tin[u] <= tin[v] && tin[v] <= tout[u];
    }
};
