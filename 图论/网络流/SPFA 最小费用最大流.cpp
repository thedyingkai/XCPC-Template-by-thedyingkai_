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
    vector<i128> d;
    vector<i64> mf;
    SPFAMinCostMaxFlow(int _n, int s, int t) : n(_n), S(s), T(t) {
        assert(0 <= S && S <= n && 0 <= T && T <= n && S != T);
        e.push_back({}), e.push_back({});
        h.resize(n + 1);
        pre.resize(n + 1);
        d.resize(n + 1);
        mf.resize(n + 1);
        vis.resize(n + 1);
        flow = cost = 0;
    }
    void add(int a, int b, i64 c, i64 w) {
        assert(c >= 0 && w != LLONG_MIN);
        e.push_back({b, c, w, h[a]});
        h[a] = e.size() - 1;
        e.push_back({a, 0, -w, h[b]});
        h[b] = e.size() - 1;
    }
    bool spfa() {
        constexpr i128 INF = i128(1) << 120;
        d.assign(n + 1, INF);
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
            i128 nextFlow = (i128) flow + mf[T];
            // 先检查可表示范围，避免费用乘法溢出后才判断。
            assert(nextFlow <= LLONG_MAX);
            assert(d[T] >= ((i128) LLONG_MIN - cost) / mf[T] &&
                   d[T] <= ((i128) LLONG_MAX - cost) / mf[T]);
            i128 nextCost = (i128) cost + (i128) mf[T] * d[T];
            for(int v = T; v != S; v = e[pre[v] ^ 1].v) {
                int i = pre[v];
                e[i].c -= mf[T], e[i ^ 1].c += mf[T];
            }
            flow = (i64) nextFlow, cost = (i64) nextCost;
        }
    }
};
