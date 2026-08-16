#include "../../template/start.cpp"

struct DSU {
    vector<int> p;
    vector<i64> sz;
    DSU(int n) : p(n), sz(n, 1) { iota(p.begin(), p.end(), 0); }
    int find(int x) { return p[x] == x ? x : p[x] = find(p[x]); }
    bool unite(int a, int b) {
        int ra = find(a), rb = find(b);
        if(ra == rb) return 0;
        if(sz[ra] < sz[rb]) swap(ra, rb);
        p[rb] = ra;
        sz[ra] += sz[rb];
        return 1;
    }
    i64 size(int x) { return sz[find(x)]; }
};
