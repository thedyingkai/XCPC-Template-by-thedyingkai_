#include "../../template/start.cpp"

struct LCA {
    int n, m;
    const vector<vector<int>>& g;
    const vector<vector<pair<int, int>>>& q;
    vector<int> p, rank, ancestor, state, ans;
    LCA(int n_, int m_, int root, const vector<vector<int>>& g_, const vector<vector<pair<int, int>>>& q_)
        : n(n_), m(m_), g(g_), q(q_) {
        p.resize(n + 1);
        rank.resize(n + 1);
        ancestor.resize(n + 1);
        state.resize(n + 1);
        ans.resize(m + 1);
        iota(p.begin(), p.end(), 0);
        iota(ancestor.begin(), ancestor.end(), 0);
        tarjan(root);
    }
    int find(int u) {
        int root = u;
        while(root != p[root]) root = p[root];
        while(u != root) {
            int next = p[u];
            p[u] = root;
            u = next;
        }
        return root;
    }
    void unite(int a, int b) {
        a = find(a), b = find(b);
        if(a == b) return;
        if(rank[a] < rank[b]) swap(a, b);
        p[b] = a;
        if(rank[a] == rank[b]) rank[a]++;
    }
    void tarjan(int root) {
        vector<int> parent(n + 1), it(n + 1), stk = {root};
        state[root] = 1;
        while(!stk.empty()) {
            int u = stk.back();
            if(it[u] < (int) g[u].size()) {
                int v = g[u][it[u]++];
                if(state[v]) continue;
                parent[v] = u;
                state[v] = 1;
                stk.push_back(v);
                continue;
            }
            state[u] = 2;
            for(auto [v, i] : q[u])
                if(state[v] == 2) ans[i] = ancestor[find(v)];
            stk.pop_back();
            if(parent[u]) {
                unite(parent[u], u);
                ancestor[find(parent[u])] = parent[u];
            }
        }
    }
};
