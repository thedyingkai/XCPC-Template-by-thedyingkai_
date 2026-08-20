#include "../../template/start.cpp"

struct SPFAMinCostMaxFlow {
    struct edge {
        int v;
        i64 c, w;
        int ne;
    };
    int n, S, T;
    i64 flow, cost;
    vector<edge> e;
    vector<int> h, pre, vis;
    vector<i64> d, mf;
    SPFAMinCostMaxFlow(int _n, int s, int t) : n(_n), S(s), T(t) {
        e.push_back({}), e.push_back({});
        h.resize(n + 1);
        pre.resize(n + 1);
        d.resize(n + 1);
        mf.resize(n + 1);
        vis.resize(n + 1);
        flow = cost = 0;
    }
    void add(int a, int b, i64 c, i64 w) {
        assert(c >= 0);
        e.push_back({b, c, w, h[a]});
        h[a] = e.size() - 1;
        e.push_back({a, 0, -w, h[b]});
        h[b] = e.size() - 1;
    }
    bool spfa() {
        d.assign(n + 1, LLONG_MAX / 4);
        mf.assign(n + 1, 0);
        vis.assign(n + 1, 0);
        queue<int> q;
        q.push(S), d[S] = 0, mf[S] = LLONG_MAX, vis[S] = 1;
        while(!q.empty()) {
            int u = q.front();
            q.pop(), vis[u] = 0;
            for(int i = h[u]; i; i = e[i].ne) {
                int v = e[i].v;
                if(e[i].c > 0 && d[v] > d[u] + e[i].w) {
                    d[v] = d[u] + e[i].w;
                    mf[v] = min(mf[u], e[i].c);
                    pre[v] = i;
                    if(!vis[v]) q.push(v), vis[v] = 1;
                }
            }
        }
        return mf[T] > 0;
    }
    void run() {
        while(spfa()) {
            for(int v = T; v != S; v = e[pre[v] ^ 1].v) {
                int i = pre[v];
                e[i].c -= mf[T], e[i ^ 1].c += mf[T];
            }
            flow += mf[T], cost += mf[T] * d[T];
        }
    }
};
