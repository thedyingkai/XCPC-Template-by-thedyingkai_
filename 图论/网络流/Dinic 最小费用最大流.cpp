#include <template/start.cpp>

struct Dinic {
    struct edge {
        i64 v, c, w, ne;
    };
    int n, S, T;
    vector<edge> e;
    vector<int> h, cur, vis, ins;
    vector<i64> d;
    i64 flow, cost;
    Dinic(int _n, int s, int t) : n(_n), S(s), T(t) {
        e.push_back({});
        e.push_back({});
        h.resize(n + 1);
        cur.resize(n + 1);
        d.resize(n + 1);
        vis.resize(n + 1);
        ins.resize(n + 1);
        flow = cost = 0;
    }
    void add(int a, int b, i64 c, i64 d) {
        e.push_back({b, c, d, h[a]});
        h[a] = e.size() - 1;
        e.push_back({a, 0, -d, h[b]});
        h[b] = e.size() - 1;
    }
    bool spfa() {
        d.assign(n + 1, LLONG_MAX / 2);
        vis.assign(n + 1, 0);
        queue<int> q;
        q.push(S);
        d[S] = 0;
        vis[S] = 1;
        while(q.size()) {
            int u = q.front();
            q.pop();
            vis[u] = 0;
            for(int i = h[u]; i; i = e[i].ne) {
                int v = e[i].v;
                i64 c = e[i].c, w = e[i].w;
                if(c > 0 && d[v] > d[u] + w) {
                    d[v] = d[u] + w;
                    if(!vis[v]) {
                        q.push(v);
                        vis[v] = 1;
                    }
                }
            }
        }
        return d[T] != LLONG_MAX / 2;
    }
    i64 dfs(int u, i64 mf) {
        if(u == T) return mf;
        i64 sum = 0;
        ins[u] = 1;
        for(int& i = cur[u]; i; i = e[i].ne) {
            int v = e[i].v;
            i64 c = e[i].c, w = e[i].w;
            if(c > 0 && !ins[v] && d[v] == d[u] + w) {
                i64 f = dfs(v, min(mf, c));
                if(f) {
                    e[i].c -= f;
                    e[i ^ 1].c += f;
                    sum += f;
                    mf -= f;
                    if(mf == 0) break;
                }
            }
        }
        ins[u] = false;
        if(sum == 0) d[u] = LLONG_MAX / 2;
        return sum;
    }
    void dinic() {
        while(spfa()) {
            cur = h;
            ins.assign(n + 1, 0);
            i64 f;
            while((f = dfs(S, LLONG_MAX)) > 0) {
                flow += f;
                cost += f * d[T];
            }
        }
    }
};
