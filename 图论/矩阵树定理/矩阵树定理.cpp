#pragma once

#include "../../数学/线性代数/线性代数.cpp"

struct MatrixTree {
    struct Edge {
        int u, v;
        i64 w;
    };
    int n;
    vector<Edge> undirected, directed;
    MatrixTree(int n_) : n(n_) { assert(n >= 1); }
    void addUndirected(int u, int v, i64 w = 1) {
        assert(1 <= u && u <= n && 1 <= v && v <= n);
        undirected.push_back({u, v, w});
    }
    void addDirected(int u, int v, i64 w = 1) {
        assert(1 <= u && u <= n && 1 <= v && v <= n);
        directed.push_back({u, v, w});
    }
    template <i64 Mod> static void addTo(i64& x, i64 v) { x = Matrix<i64, Mod>::add(x, v); }
    template <i64 Mod> static void subFrom(i64& x, i64 v) { x = Matrix<i64, Mod>::sub(x, v); }
    template <i64 Mod> i64 cofactor(const Matrix<i64, Mod>& lap, int root) const {
        assert(1 <= root && root <= n);
        if(n == 1) return 1;
        root--;
        Matrix<i64, Mod> minor(n - 1, n - 1);
        for(int i = 0, x = 0; i < n; i++) {
            if(i == root) continue;
            for(int j = 0, y = 0; j < n; j++) {
                if(j == root) continue;
                minor[x][y++] = lap[i][j];
            }
            x++;
        }
        return Matrix<i64, Mod>::norm(minor.det());
    }
    template <i64 Mod = 1000000007> i64 countUndirected(int root = 1) const {
        Matrix<i64, Mod> lap(n, n);
        for(auto [u, v, w] : undirected) {
            if(u == v) continue;
            --u, --v;
            addTo<Mod>(lap[u][u], w), addTo<Mod>(lap[v][v], w);
            subFrom<Mod>(lap[u][v], w), subFrom<Mod>(lap[v][u], w);
        }
        return cofactor<Mod>(lap, root);
    }
    // 每个非根点恰选一条出边，所有边最终指向 root。
    template <i64 Mod = 1000000007> i64 countInArborescence(int root) const {
        Matrix<i64, Mod> lap(n, n);
        for(auto [u, v, w] : directed) {
            if(u == v) continue;
            --u, --v;
            addTo<Mod>(lap[u][u], w);
            subFrom<Mod>(lap[u][v], w);
        }
        return cofactor<Mod>(lap, root);
    }
    // 每个非根点恰选一条入边，所有点都能从 root 到达。
    template <i64 Mod = 1000000007> i64 countOutArborescence(int root) const {
        Matrix<i64, Mod> lap(n, n);
        for(auto [u, v, w] : directed) {
            if(u == v) continue;
            --u, --v;
            addTo<Mod>(lap[v][v], w);
            subFrom<Mod>(lap[v][u], w);
        }
        return cofactor<Mod>(lap, root);
    }
};
