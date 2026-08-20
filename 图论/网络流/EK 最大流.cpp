#include "../../template/start.cpp"

struct EK {
    struct edge {
        int v;
        i64 c;
        int ne;
    };
    int n, S, T;
    vector<edge> e;
    vector<int> h, pre;
    vector<i64> mf;
    EK(int _n, int s, int t) : n(_n), S(s), T(t) {
        e.push_back({}), e.push_back({});
        h.resize(n + 1);
        pre.resize(n + 1);
        mf.resize(n + 1);
    }
    void add(int a, int b, i64 c) {
        assert(c >= 0);
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
        while(!q.empty()) {
            int u = q.front();
            q.pop();
            for(int i = h[u]; i; i = e[i].ne) {
                int v = e[i].v;
                if(!mf[v] && e[i].c > 0) {
                    mf[v] = min(mf[u], e[i].c);
                    pre[v] = i;
                    q.push(v);
                    if(v == T) return true;
                }
            }
        }
        return false;
    }
    i64 ek() {
        i64 flow = 0;
        while(bfs()) {
            for(int v = T; v != S; v = e[pre[v] ^ 1].v) {
                int i = pre[v];
                e[i].c -= mf[T], e[i ^ 1].c += mf[T];
            }
            flow += mf[T];
        }
        return flow;
    }
};
