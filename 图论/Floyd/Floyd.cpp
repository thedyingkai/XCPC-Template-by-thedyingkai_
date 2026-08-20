#include "../../template/start.cpp"

struct Floyd {
    static constexpr i64 INF = LLONG_MAX / 4;
    int n;
    vector<vector<i64>> dist;
    vector<vector<int>> next;
    Floyd(int nodes) : n(nodes), dist(nodes + 1, vector<i64>(nodes + 1, INF)), next(nodes + 1, vector<int>(nodes + 1)) {
        assert(n >= 1);
        for(int i = 1; i <= n; i++) dist[i][i] = 0, next[i][i] = i;
    }
    void add_edge(int u, int v, long long w) {
        assert(1 <= u && u <= n && 1 <= v && v <= n);
        assert(-INF < w && w < INF);
        if(dist[u][v] > w) dist[u][v] = w, next[u][v] = v;
    }
    void run() {
        for(int k = 1; k <= n; k++) {
            for(int i = 1; i <= n; i++) {
                if(dist[i][k] == INF) continue;
                for(int j = 1; j <= n; j++) {
                    if(dist[k][j] == INF) continue;
                    i128 value = (i128) dist[i][k] + dist[k][j];
                    value = max<i128>(value, -INF);
                    if(dist[i][j] > value)
                        dist[i][j] = (i64) value, next[i][j] = next[i][k];
                }
            }
        }
    }
    bool has_negative_cycle() const {
        for(int i = 1; i <= n; i++)
            if(dist[i][i] < 0) return true;
        return false;
    }
    bool affected_by_negative_cycle(int u, int v) const {
        for(int k = 1; k <= n; k++)
            if(dist[u][k] != INF && dist[k][k] < 0 && dist[k][v] != INF) return true;
        return false;
    }
    i64 query(int i, int j) const { return dist[i][j]; }
    vector<int> path(int u, int v) const {
        if(!next[u][v] || affected_by_negative_cycle(u, v)) return {};
        vector<int> answer = {u};
        while(u != v) {
            u = next[u][v];
            if(!u || (int) answer.size() > n) return {};
            answer.push_back(u);
        }
        return answer;
    }
};
