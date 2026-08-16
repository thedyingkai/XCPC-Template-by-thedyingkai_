#include "../树链剖分/树链剖分.cpp"

struct VirtualTree {
    int n;
    const HLD& hld;
    vector<vector<pair<int, int>>> g;
    vector<int> nodes;
    VirtualTree(int n_, const HLD& hld_) : n(n_), hld(hld_), g(n + 1) {}
    bool ancestor(int u, int v) const { return hld.dfn[u] <= hld.dfn[v] && hld.dfn[v] < hld.dfn[u] + hld.sz[u]; }
    int build(vector<int> key) {
        for(int u : nodes) g[u].clear();
        nodes.clear();
        if(key.empty()) return 0;
        sort(key.begin(), key.end(), [&](int a, int b) { return hld.dfn[a] < hld.dfn[b]; });
        key.erase(unique(key.begin(), key.end()), key.end());
        int m = key.size();
        for(int i = 1; i < m; i++) key.push_back(hld.lca(key[i - 1], key[i]));
        sort(key.begin(), key.end(), [&](int a, int b) { return hld.dfn[a] < hld.dfn[b]; });
        key.erase(unique(key.begin(), key.end()), key.end());
        nodes = key;
        vector<int> stk;
        stk.push_back(key[0]);
        for(int i = 1; i < (int) key.size(); i++) {
            int u = key[i];
            while(!ancestor(stk.back(), u)) stk.pop_back();
            int p = stk.back();
            g[p].push_back({u, hld.dep[u] - hld.dep[p]});
            stk.push_back(u);
        }
        return key[0];
    }
};
