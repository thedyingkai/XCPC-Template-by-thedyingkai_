#include "Dinic 最大流最小割.cpp"

i64 mincutEdgeCount(int n, int S, int T, const vector<tuple<int, int, i64>>& edges) {
    i64 base = (i64) edges.size() + 1;
    Dinic dinic(n, S, T);
    for(auto [u, v, c] : edges) {
        dinic.add(u, v, (i128) c * base + 1);
    }
    return dinic.dinic() % base;
}
