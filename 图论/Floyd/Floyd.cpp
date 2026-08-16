#include "../../template/start.cpp"

struct Floyd {
    static constexpr i64 INF = LLONG_MAX / 4;
    int n;
    vector<vector<i64>> dist;
    Floyd(int nodes) : n(nodes), dist(nodes + 1, vector<i64>(nodes + 1, INF)) {
        for(int i = 1; i <= n; i++) dist[i][i] = 0;
    }
    void add_edge(int u, int v, long long w) {
        if(dist[u][v] > w) dist[u][v] = w;
    }
    void run() {
        for(int k = 1; k <= n; k++) {
            for(int i = 1; i <= n; i++) {
                if(dist[i][k] == INF) continue;
                for(int j = 1; j <= n; j++) {
                    if(dist[k][j] == INF) continue;
                    if(dist[i][j] > dist[i][k] + dist[k][j]) dist[i][j] = dist[i][k] + dist[k][j];
                }
            }
        }
    }
    bool has_negative_cycle() {
        for(int i = 1; i <= n; i++)
            if(dist[i][i] < 0) return true;
        return false;
    }
    i64 query(int i, int j) { return dist[i][j]; }
};
