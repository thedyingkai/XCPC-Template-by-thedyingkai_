#include "../../最大流/Dinic 分层增广/Dinic 最大流/Dinic 最大流最小割.cpp"

struct CutResult {
    i64 capacity, edgeCount;
};

CutResult cutResult(int n, int S, int T, const vector<tuple<int, int, i64>>& edges) {
    i64 base = (i64) edges.size() + 1;
    Dinic dinic(n, S, T);
    for(auto [u, v, c] : edges) {
        i128 encoded = (i128) c * base + 1;
        dinic.add(u, v, (i64) encoded);
    }
    i64 value = dinic.dinic();
    return {value / base, value % base};
}

i64 cutCount(int n, int S, int T, const vector<tuple<int, int, i64>>& edges) {
    return cutResult(n, S, T, edges).edgeCount;
}
