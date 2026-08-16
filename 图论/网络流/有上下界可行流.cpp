#include "Dinic 最大流最小割.cpp"

struct LowerBoundFlow {
    int n, S, T;
    bool built, ok;
    Dinic flow;
    vector<i64> balance, low;
    vector<int> id;
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
        if(s) flow.add(t, s, LLONG_MAX / 4);
        i64 need = 0;
        for(int u = 1; u <= n; u++) {
            if(balance[u] > 0)
                flow.add(S, u, balance[u]), need += balance[u];
            else if(balance[u] < 0)
                flow.add(u, T, -balance[u]);
        }
        return ok = flow.dinic() == need;
    }
    i64 edgeFlow(int k) const {
        assert(ok && 0 <= k && k < (int) id.size());
        return low[k] + flow.e[id[k] ^ 1].c;
    }
};
