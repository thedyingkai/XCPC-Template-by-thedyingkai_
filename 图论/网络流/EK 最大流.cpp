#include "../../template/start.cpp"

struct EK {
    struct edge {
        i64 v, c, ne;
    };
    int n, S, T;
    vector<edge> e;
    vector<int> h;
    vector<i64> mf, pre;
    EK(int _n, int s, int t) : n(_n), S(s), T(t) {
        e.push_back({}), e.push_back({});
        h.resize(n + 1);
        mf.resize(n + 1);
        pre.resize(n + 1);
    }
    void add(int a, int b, i64 c) {
        e.push_back({b, c, h[a]});
        h[a] = e.size() - 1;
        e.push_back({a, 0, h[b]});
        h[b] = e.size() - 1;
    }
    bool bfs() {
        mf.assign(n + 1, 0);
        queue<int> q;
        q.push(S);
        mf[S] = LLONG_MAX;
        while(q.size()) {
            int u = q.front();
            q.pop();
            for(int i = h[u]; i; i = e[i].ne) {
                i64 v = e[i].v;
                if(mf[v] == 0 && e[i].c) {
                    mf[v] = min(mf[u], e[i].c);
                    pre[v] = i;
                    q.push(v);
                    if(v == T) return 1;
                }
            }
        }
        return 0;
    }
    i64 ek() {
        i64 flow = 0;
        while(bfs()) {
            int v = T;
            while(v != S) {
                int i = pre[v];
                e[i].c -= mf[T];
                e[i ^ 1].c += mf[T];
                v = e[i ^ 1].v;
            }
            flow += mf[T];
        }
        return flow;
    }
};
