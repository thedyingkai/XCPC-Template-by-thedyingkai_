#include <template/start.cpp>

struct Dinic {
    struct edge {
        i64 v, c, ne;
    };
    int n, S, T;
    vector<edge> e;
    vector<int> h, d, cur, vis;
    Dinic(int _n, int s, int t) : n(_n), S(s), T(t) {
        e.push_back({}), e.push_back({});
        h.resize(n + 1);
        d.resize(n + 1);
        cur.resize(n + 1);
        vis.resize(n + 1);
    }
    void add(int a, int b, i64 c) {
        e.push_back({b, c, h[a]});
        h[a] = e.size() - 1;
        e.push_back({a, 0, h[b]});
        h[b] = e.size() - 1;
    }
    bool bfs() {
        d.assign(n + 1, 0);
        queue<int> q;
        q.push(S);
        d[S] = 1;
        while(q.size()) {
            int u = q.front();
            q.pop();
            for(int i = h[u]; i; i = e[i].ne) {
                int v = e[i].v;
                if(d[v] == 0 && e[i].c) {
                    d[v] = d[u] + 1;
                    q.push(v);
                    if(v == T) return 1;
                }
            }
        }
        return 0;
    }
    i64 dfs(int u, i64 mf) {
        if(u == T) return mf;
        i64 sum = 0;
        for(int i = cur[u]; i; i = e[i].ne) {
            cur[u] = i;
            int v = e[i].v;
            if(d[v] == d[u] + 1 && e[i].c) {
                i64 f = dfs(v, min(mf, e[i].c));
                e[i].c -= f;
                e[i ^ 1].c += f;
                sum += f;
                mf -= f;
                if(mf == 0) break;
            }
        }
        if(sum == 0) d[u] = 0;
        return sum;
    }
    i64 dinic() {
        i64 flow = 0;
        while(bfs()) {
            cur = h;
            flow += dfs(S, LLONG_MAX);
        }
        return flow;
    }
    void mincut(int u) {
        vis[u] = 1;
        for(int i = h[u]; i; i = e[i].ne) {
            int v = e[i].v;
            if(!vis[v] && e[i].c) mincut(v);
        }
    }
};
