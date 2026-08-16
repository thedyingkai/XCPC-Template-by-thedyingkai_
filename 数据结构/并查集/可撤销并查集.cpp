#ifndef XCPC_ROLLBACK_DSU
#define XCPC_ROLLBACK_DSU

#include "../../template/start.cpp"

struct RollbackDSU {
    struct Change {
        int a, b, sizeA;
    };
    int components;
    vector<int> p, sz;
    vector<Change> history;
    RollbackDSU(int n) : components(n), p(n + 1), sz(n + 1, 1) { iota(p.begin(), p.end(), 0); }
    int find(int x) const {
        while(p[x] != x) x = p[x];
        return x;
    }
    bool unite(int a, int b) {
        a = find(a), b = find(b);
        if(a == b) return false;
        if(sz[a] < sz[b]) swap(a, b);
        history.push_back({a, b, sz[a]});
        p[b] = a;
        sz[a] += sz[b];
        components--;
        return true;
    }
    int snapshot() const { return history.size(); }
    void rollback(int snap) {
        assert(0 <= snap && snap <= (int) history.size());
        while((int) history.size() > snap) {
            auto [a, b, sizeA] = history.back();
            history.pop_back();
            p[b] = b;
            sz[a] = sizeA;
            components++;
        }
    }
    bool same(int a, int b) const { return find(a) == find(b); }
    int size(int x) const { return sz[find(x)]; }
};

#endif
