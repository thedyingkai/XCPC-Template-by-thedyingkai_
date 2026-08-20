#include "Dinic 最大流最小割.cpp"

struct LowerBoundFlow {
    int n, S, T;
    bool built, ok;
    Dinic flow;
    vector<i64> balance, low;
    vector<int> id, auxiliary;
    int returnEdge;
    i64 returnFlow;
    LowerBoundFlow(int n_) : n(n_), S(n + 1), T(n + 2), built(false), ok(false), flow(n + 2, S, T), balance(n + 1) {}
    int add(int u, int v, i64 lower, i64 upper) {
        assert(0 <= lower && lower <= upper);
        int idx = flow.e.size();
        flow.add(u, v, upper - lower);
        balance[u] -= lower;
        balance[v] += lower;
        id.push_back(idx);
        low.push_back(lower);
        return (int) id.size() - 1;
    }
    bool feasible(int s = 0, int t = 0) {
        assert(!built && ((s == 0) == (t == 0)));
        built = true;
        returnEdge = -1, returnFlow = 0;
        if(s) {
            returnEdge = (int) flow.e.size();
            flow.add(t, s, LLONG_MAX / 4);
            auxiliary.push_back(returnEdge);
        }
        i64 need = 0;
        for(int u = 1; u <= n; u++) {
            if(balance[u] > 0) {
                auxiliary.push_back((int) flow.e.size());
                flow.add(S, u, balance[u]), need += balance[u];
            } else if(balance[u] < 0) {
                auxiliary.push_back((int) flow.e.size());
                flow.add(u, T, -balance[u]);
            }
        }
        ok = flow.dinic() == need;
        if(ok && returnEdge != -1) returnFlow = flow.e[returnEdge ^ 1].c;
        return ok;
    }
    optional<i64> maxFlow(int s, int t) {
        if(!feasible(s, t)) return nullopt;
        for(int edge : auxiliary) flow.e[edge].c = flow.e[edge ^ 1].c = 0;
        flow.S = s, flow.T = t;
        return returnFlow + flow.dinic();
    }
    i64 edgeFlow(int k) const {
        assert(ok && 0 <= k && k < (int) id.size());
        return low[k] + flow.e[id[k] ^ 1].c;
    }
};
