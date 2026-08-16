#include "../../template/start.cpp"

struct Dij {
    const i64 INF = LLONG_MAX / 3;
    struct edge {
        int v;
        i64 w;
    };
    struct node {
        i64 dist;
        int u;
        bool operator>(const node& a) const { return dist > a.dist; }
    };
    int n;
    vector<vector<edge>> G;
    vector<i64> dist;
    vector<int> vis, parent;
    Dij(int N) : n(N), G(N + 1), dist(N + 1), vis(N + 1), parent(N + 1, -1) {}
    void add(int u, int v, i64 w) { G[u].push_back({v, w}); }
    vector<i64> dij(int src) {
        fill(dist.begin(), dist.end(), INF);
        fill(vis.begin(), vis.end(), 0);
        fill(parent.begin(), parent.end(), -1);
        priority_queue<node, vector<node>, greater<node>> pq;
        dist[src] = 0;
        pq.push({0, src});
        while(!pq.empty()) {
            int u = pq.top().u;
            pq.pop();
            if(vis[u]) continue;
            vis[u] = 1;
            for(auto [v, w] : G[u]) {
                if(dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    parent[v] = u; // 记录路径父节点
                    pq.push({dist[v], v});
                }
            }
        }
        return dist;
    }
    vector<int> get_path(int target) {
        vector<int> path;
        if(dist[target] == INF) return path;
        for(int cur = target; cur != -1; cur = parent[cur]) path.push_back(cur);
        reverse(path.begin(), path.end());
        return path;
    }
};
