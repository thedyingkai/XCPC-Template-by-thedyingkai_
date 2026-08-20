#include "../../template/start.cpp"

struct MinCostMaxFlow {
    struct edge {
        int v, ne;
        i64 c, w;
    };
    int n, S, T;
    vector<edge> e;
    vector<int> h, pre, vis;
    vector<i64> d, potential;
    i64 flow, cost;
    bool initialized, hasNegative;
    MinCostMaxFlow(int _n, int s, int t) : n(_n), S(s), T(t) {
        assert(0 <= S && S <= n && 0 <= T && T <= n && S != T);
        e.push_back({});
        e.push_back({});
        h.resize(n + 1);
        pre.resize(n + 1);
        d.resize(n + 1);
        vis.resize(n + 1);
        potential.resize(n + 1);
        flow = cost = 0;
        initialized = hasNegative = false;
    }
    void add(int a, int b, i64 c, i64 w) {
        assert(c >= 0);
        if(c > 0 && w < 0) hasNegative = true;
        e.push_back({b, h[a], c, w});
        h[a] = e.size() - 1;
        e.push_back({a, h[b], 0, -w});
        h[b] = e.size() - 1;
    }
    bool shortestPath() {
        constexpr i64 INF = LLONG_MAX / 4;
        d.assign(n + 1, INF);
        pre.assign(n + 1, 0);
        d[S] = 0;
        if(!initialized && hasNegative) {
            vis.assign(n + 1, 0);
            queue<int> q;
            q.push(S), vis[S] = 1;
            while(!q.empty()) {
                int u = q.front();
                q.pop(), vis[u] = 0;
                for(int i = h[u]; i; i = e[i].ne) if(e[i].c > 0) {
                    int v = e[i].v;
                    if(d[v] > d[u] + e[i].w) {
                        d[v] = d[u] + e[i].w;
                        pre[v] = i;
                        if(!vis[v]) q.push(v), vis[v] = 1;
                    }
                }
            }
            if(d[T] == INF) return false;
            for(int u = 0; u <= n; u++) if(d[u] != INF) potential[u] = d[u];
            initialized = true;
            return true;
        }
        initialized = true;
        int heapHeight = bit_width((unsigned) n + 1);
        if(1LL * (n + 1) * (n + 1) < (i64) e.size() * heapHeight) {
            vis.assign(n + 1, 0);
            for(int step = 0; step <= n; step++) {
                int u = -1;
                for(int v = 0; v <= n; v++) {
                    if(!vis[v] && d[v] != INF && (u == -1 || d[v] < d[u])) u = v;
                }
                if(u == -1) break;
                vis[u] = 1;
                for(int i = h[u]; i; i = e[i].ne) if(e[i].c > 0) {
                    int v = e[i].v;
                    i64 w = e[i].w + potential[u] - potential[v];
                    if(d[v] > d[u] + w) d[v] = d[u] + w, pre[v] = i;
                }
            }
        } else {
            priority_queue<pair<i64, int>, vector<pair<i64, int>>, greater<>> q;
            q.push({0, S});
            while(!q.empty()) {
                auto [du, u] = q.top();
                q.pop();
                if(du != d[u]) continue;
                for(int i = h[u]; i; i = e[i].ne) if(e[i].c > 0) {
                    int v = e[i].v;
                    i64 w = e[i].w + potential[u] - potential[v];
                    if(d[v] > du + w) d[v] = du + w, pre[v] = i, q.push({d[v], v});
                }
            }
        }
        if(d[T] == INF) return false;
        for(int u = 0; u <= n; u++) if(d[u] != INF) potential[u] += d[u];
        return true;
    }
    void run() {
        while(shortestPath()) {
            i64 f = LLONG_MAX;
            for(int v = T; v != S; v = e[pre[v] ^ 1].v) {
                assert(pre[v]);
                f = min(f, e[pre[v]].c);
            }
            for(int v = T; v != S; v = e[pre[v] ^ 1].v) {
                int id = pre[v];
                e[id].c -= f;
                e[id ^ 1].c += f;
            }
            flow += f;
            cost += f * (potential[T] - potential[S]);
        }
    }
};
