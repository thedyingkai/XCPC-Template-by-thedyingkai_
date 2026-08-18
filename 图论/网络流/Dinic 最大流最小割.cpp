#pragma once

#include "../../template/start.cpp"

struct Dinic {
    struct edge {
        int v, ne;
        i64 c;
    };
    int n, S, T;
    vector<edge> e;
    vector<int> h, d, cur, vis;
    Dinic(int n, int s, int t) : n(n), S(s), T(t), h(n + 1), d(n + 1), cur(n + 1), vis(n + 1) {
        e.push_back({});
        e.push_back({});
    }
    void add(int u, int v, i64 c) {
        e.push_back({v, h[u], c});
        h[u] = (int) e.size() - 1;
        e.push_back({u, h[v], 0});
        h[v] = (int) e.size() - 1;
    }
    bool bfs() {
        fill(d.begin(), d.end(), 0);
        queue<int> q;
        q.push(S);
        d[S] = 1;
        while(!q.empty()) {
            int u = q.front();
            q.pop();
            for(int i = h[u]; i; i = e[i].ne) {
                int v = e[i].v;
                if(d[v] == 0 && e[i].c > 0) {
                    d[v] = d[u] + 1;
                    q.push(v);
                }
            }
        }
        return d[T] != 0;
    }
    i64 dfs(int u, i64 limit) {
        if(u == T) return limit;
        i64 flow = 0;
        for(int& i = cur[u]; i; i = e[i].ne) {
            int v = e[i].v;
            if(d[v] == d[u] + 1 && e[i].c > 0) {
                i64 f = dfs(v, min(limit, e[i].c));
                e[i].c -= f;
                e[i ^ 1].c += f;
                flow += f;
                limit -= f;
                if(limit == 0) break;
            }
        }
        if(flow == 0) d[u] = 0;
        return flow;
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
            if(!vis[v] && e[i].c > 0) mincut(v);
        }
    }
};
