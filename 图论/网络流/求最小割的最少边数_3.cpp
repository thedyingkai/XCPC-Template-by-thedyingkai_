#include "Dinic 最大流最小割.cpp"

struct MincutEdgeCountResult {
    i64 capacity, edgeCount;
};

MincutEdgeCountResult mincutEdgeCountResult(int n, int S, int T, const vector<tuple<int, int, i64>>& edges) {
    i64 base = (i64) edges.size() + 1;
    Dinic dinic(n, S, T);
    for(auto [u, v, c] : edges) {
        i128 encoded = (i128) c * base + 1;
        assert(0 <= c && encoded <= LLONG_MAX);
        dinic.add(u, v, (i64) encoded);
    }
    i64 value = dinic.dinic();
    return {value / base, value % base};
}

i64 mincutEdgeCount(int n, int S, int T, const vector<tuple<int, int, i64>>& edges) {
    return mincutEdgeCountResult(n, S, T, edges).edgeCount;
}
