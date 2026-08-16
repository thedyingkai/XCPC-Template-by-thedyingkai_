#include "../../template/start.cpp"

struct DSU {
    vector<int> p;
    vector<i64> sz, weight; // weight[x] = x 到 p[x] 的边权
    DSU(int n) : p(n), sz(n, 1), weight(n, 0) { iota(p.begin(), p.end(), 0); }
    int find(int x) { // 仅在 find 中增加 weight 更新
        if(p[x] == x) return x;
        int root = find(p[x]);
        weight[x] += weight[p[x]]; // 累加路径权值
        p[x] = root;
        return p[x];
    }
    bool unite(int a, int b) { // 带权版本
        return unite(a, b, 0); // 默认权值为 0（普通合并）
    }
    bool unite(int a, int b, i64 w) { // 带权合并，a -> b 的权值为 w（即 val[a] - val[b] = w）
        int ra = find(a), rb = find(b);
        if(ra == rb) return 0;
        if(sz[ra] < sz[rb]) {
            swap(ra, rb);
            swap(a, b);
            w = -w; // 反向
        }
        p[rb] = ra;
        weight[rb] = weight[a] - weight[b] - w;
        sz[ra] += sz[rb];
        return 1;
    }
    i64 size(int x) { return sz[find(x)]; }
    i64 dist(int x) { // 查询 x 到根的权值
        find(x);
        return weight[x];
    }
    optional<i64> query(int a, int b) { // 查询 a 和 b 的权值差（a - b）
        if(find(a) != find(b)) return nullopt;
        return weight[a] - weight[b];
    }
};
