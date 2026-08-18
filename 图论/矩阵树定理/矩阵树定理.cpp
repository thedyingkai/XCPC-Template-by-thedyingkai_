#pragma once

#include "../../数学/线性代数/线性代数.cpp"

struct MatrixTree {
    struct Edge {
        int u, v;
        i64 w;
    };
    int n;
    vector<Edge> undirected, directed;
    MatrixTree(int n_) : n(n_) {}
    void addUndirected(int u, int v, i64 w = 1) { undirected.push_back({u, v, w}); }
    void addDirected(int u, int v, i64 w = 1) { directed.push_back({u, v, w}); }
    static void addTo(i64& x, i64 v) { x = Matrix<i64>::add(x, v); }
    static void subFrom(i64& x, i64 v) { x = Matrix<i64>::sub(x, v); }
    i64 cofactor(const Matrix<i64>& lap, int root) const {
        if(n == 1) return 1;
        root--;
        Matrix<i64> minor(n - 1, n - 1);
        for(int i = 0, x = 0; i < n; i++) {
            if(i == root) continue;
            for(int j = 0, y = 0; j < n; j++) {
                if(j == root) continue;
                minor[x][y++] = lap[i][j];
            }
            x++;
        }
        return Matrix<i64>::norm(minor.det());
    }
    i64 countUndirected(int root = 1) const {
        Matrix<i64> lap(n, n);
        for(auto [u, v, w] : undirected) {
            if(u == v) continue;
            --u, --v;
            addTo(lap[u][u], w), addTo(lap[v][v], w);
            subFrom(lap[u][v], w), subFrom(lap[v][u], w);
        }
        return cofactor(lap, root);
    }
    // 每个非根点恰选一条出边，所有边最终指向 root。
    i64 countInArborescence(int root) const {
        Matrix<i64> lap(n, n);
        for(auto [u, v, w] : directed) {
            if(u == v) continue;
            --u, --v;
            addTo(lap[u][u], w);
            subFrom(lap[u][v], w);
        }
        return cofactor(lap, root);
    }
    // 每个非根点恰选一条入边，所有点都能从 root 到达。
    i64 countOutArborescence(int root) const {
        Matrix<i64> lap(n, n);
        for(auto [u, v, w] : directed) {
            if(u == v) continue;
            --u, --v;
            addTo(lap[v][v], w);
            subFrom(lap[v][u], w);
        }
        return cofactor(lap, root);
    }
};
