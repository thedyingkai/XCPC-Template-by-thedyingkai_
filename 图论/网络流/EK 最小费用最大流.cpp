#include "../../template/start.cpp"

struct EK {
    struct edge {
        i64 v, c, w, ne;
    };
    int n, S, T;
    i64 flow, cost;
    vector<edge> e;
    vector<int> h, pre, vis;
    vector<i64> d, mf;
    EK(int _n, int s, int t) : n(_n), S(s), T(t) {
        e.push_back({}), e.push_back({});
        h.resize(n + 1);
        d.resize(n + 1);
        mf.resize(n + 1);
        pre.resize(n + 1);
        vis.resize(n + 1);
        flow = cost = 0;
    }
    void add(int a, int b, i64 c, i64 d) {
        e.push_back({b, c, d, h[a]});
        h[a] = e.size() - 1;
        e.push_back({a, 0, -d, h[b]});
        h[b] = e.size() - 1;
    }
    bool spfa() {
        d.assign(n + 1, LLONG_MAX / 4);
        mf.assign(n + 1, 0);
        vis.assign(n + 1, 0);
        queue<int> q;
        q.push(S);
        d[S] = 0, mf[S] = LLONG_MAX, vis[S] = 1;
        while(q.size()) {
            int u = q.front();
            q.pop();
            vis[u] = 0;
            for(int i = h[u]; i; i = e[i].ne) {
                int v = e[i].v;
                i64 c = e[i].c, w = e[i].w;
                if(d[v] > d[u] + w && c) {
                    d[v] = d[u] + w;
                    mf[v] = min(mf[u], c);
                    pre[v] = i;
                    if(!vis[v]) {
                        q.push(v);
                        vis[v] = 1;
                    }
                }
            }
        }
        return mf[T] > 0;
    }
    void ek() {
        while(spfa()) {
            int v = T;
            while(v != S) {
                int i = pre[v];
                e[i].c -= mf[T];
                e[i ^ 1].c += mf[T];
                v = e[i ^ 1].v;
            }
            flow += mf[T];
            cost += mf[T] * d[T];
        }
    }
};
