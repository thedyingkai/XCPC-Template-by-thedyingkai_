#include "../../数据结构/并查集/可撤销并查集.cpp"

struct DynamicConnectivity {
    struct Operation {
        int type, u, v;
    };
    int n;
    vector<Operation> op;
    DynamicConnectivity(int n_) : n(n_) {}
    void add(int u, int v) {
        if(u > v) swap(u, v);
        op.push_back({1, u, v});
    }
    void erase(int u, int v) {
        if(u > v) swap(u, v);
        op.push_back({2, u, v});
    }
    void query(int u, int v) { op.push_back({3, u, v}); }
    void
    addInterval(vector<vector<pair<int, int>>>& seg, int u, int l, int r, int ql, int qr, pair<int, int> edge) const {
        if(ql <= l && r <= qr) {
            seg[u].push_back(edge);
            return;
        }
        int mid = (l + r) >> 1;
        if(ql <= mid) addInterval(seg, u << 1, l, mid, ql, qr, edge);
        if(qr > mid) addInterval(seg, u << 1 | 1, mid + 1, r, ql, qr, edge);
    }
    vector<int> solve() const {
        int q = op.size();
        if(q == 0) return {};
        vector<vector<pair<int, int>>> seg(4 * q);
        map<pair<int, int>, vector<int>> active;
        for(int i = 0; i < q; i++) {
            auto [type, u, v] = op[i];
            pair<int, int> edge = {u, v};
            if(type == 1)
                active[edge].push_back(i);
            else if(type == 2) {
                assert(active.count(edge) && !active[edge].empty());
                int l = active[edge].back();
                active[edge].pop_back();
                if(l <= i - 1) addInterval(seg, 1, 0, q - 1, l, i - 1, edge);
            }
        }
        for(auto& [edge, starts] : active)
            for(int l : starts) addInterval(seg, 1, 0, q - 1, l, q - 1, edge);
        RollbackDSU dsu(n);
        vector<int> ans;
        function<void(int, int, int)> dfs = [&](int u, int l, int r) {
            int snap = dsu.snapshot();
            for(auto [a, b] : seg[u]) dsu.unite(a, b);
            if(l == r) {
                if(op[l].type == 3) ans.push_back(dsu.same(op[l].u, op[l].v));
            } else {
                int mid = (l + r) >> 1;
                dfs(u << 1, l, mid);
                dfs(u << 1 | 1, mid + 1, r);
            }
            dsu.rollback(snap);
        };
        dfs(1, 0, q - 1);
        return ans;
    }
};
